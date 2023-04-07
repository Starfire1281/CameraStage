classdef imageProcessing < handle
    % This class is intended to process our image information received from
    % StepperController presumably via a file, and throw it through Dan's
    % software

    % This is only built to handle one image set at a time, so each object
    % should have a different set of images

    %TODO: Figure out how to map out the original path.

    properties (Access = public)%cuz I have nice getters and setters
        %The experimental parameters, this includes images and distances
        ex
        df
        wv
        %UnitConstant object
        u = unitsConstants.unitsSI;
        %The associated shifts
        pixelShifts;
    end
    
    methods (Access = public)
        % The intention is to make this object once for a given run, then modify what data it
        % has.
        function obj = imageProcessing(varargin)
            obj.ex = experiment;
            switch nargin
                case 0
                    %   Make an empty imageProcessing object to modify later
                case 5
                    %   Create one using everything!
                    %dimensionsDataXY (size of detector in pixels),detectorPixelSize (actual size of each pixel),lambda,distanceObject2Diffuser,distanceDiffuser2Detector
                    obj.setDimensionsData(varargin{1}(1),varargin{1}(2));
                    obj.setDetectorPixelSize(varargin{2}(1),varargin{2}(2));
                    obj.setWavelength(varargin{3});
                    obj.setMicroscopeDistances(varargin{4},varargin{5});
                    obj.mkDfWv;
                otherwise
                    error('ImageProcessing:InvalidArguments', 'ImageProcessing constructor expects 5 arguments!');
            end
        end


        %Load An Image Set Into Our Image Processing Object
        function loadImageDataFromFile(obj)
            disp("Please select the folder you would like to load images from");
            imagesPath = uigetdir("./ImageFiles");
            imageFiles = dir([imagesPath '/*.png']);
            obj.ex.numberOfPositions = length(imageFiles);
            imageData = zeros(obj.ex.dimensionsDataX,obj.ex.dimensionsDataY,obj.ex.numberOfPositions);
            for i = 1:(obj.ex.numberOfPositions)
                imageData(:,:,i) = imread(append(imagesPath,'\',imageFiles(i).name));
            end
            obj.setImageData(imageData);
        end

        %Convolve the loaded images
        function convolveFromData(obj)
            %This convolves our data from our image data
            obj.pixelShifts = zeros(2,obj.ex.numberOfPositions-1);
            image1 = obj.getImageFrame(1);
            for i = 2:(obj.ex.numberOfPositions)
                image2 = obj.getImageFrame(i);
                [shiftx,shifty] = findShift2Images(image1,image2);
                disp("Shift x = ",shiftx);
                disp("Shift y = ",shifty);
                [obj.pixelShifts(1,i-1),obj.pixelShifts(2,i-1)] = [shiftx,shifty];
            end
        end

        %Create diffuser and wave class randomizing them
        %Danger! number of Modes wave and number of wavelength currently
        %hard coded
        function mkDfWv(obj)
            %Diffiser gen
            obj.df = diffuserClass(obj.ex);
            obj.df.diffuserTypeString = "random";
            obj.df.generateDiffuser();
            %Wave gen
            obj.ex.numberOfWavelengths = 1;     %!!!!!!!!!!
            obj.wv = waveClass(obj.ex);
            disp(size(obj.wv.propagationPhase));
            obj.wv.numberOfModesWave = 1;       %!!!!!!!!!!
            obj.wv.generateWaveFromConstant();
            obj.wv.dataWave = rand(size(obj.wv.dataWave)) .* exp(1i*rand(size(obj.wv.dataWave)));
        end

        %Run Dan's code
        %function runPtychographyAlgorithm(obj)
            

        %Display our data
        function displayPixelPositions(obj)
            scatter(obj.pixelShifts(1,:),obj.pixelShifts(2,:));
        end

        %Getters and Setters
        %Pixel sizes
        %Camera dists
        %Lambda
        %Experimental distances
        %Image data
        function setDetectorPixelSize(obj,xSize,ySize)
            %Camera pixel sizes
            obj.ex.detectorPixelSizeX = xSize;
            obj.ex.detectorPixelSizeY = ySize;
        end
        function [xSize,ySize] = getDetectorPixelSize(obj)
            %Camera pixle sizes
            xSize = obj.ex.detectorPixelSizeX;
            ySize = obj.ex.detectorPixelSizeY;
        end
        function setDimensionsData(obj,xSize,ySize)
            %Camera pixle sizes
            obj.ex.dimensionsDataX = xSize;
            obj.ex.dimensionsDataY = ySize;
        end
        function [xSize,ySize] = getDimensionsData(obj)
            %Camera pixle sizes
            xSize = obj.ex.dimensionsDataX;
            ySize = obj.ex.dimensionsDataY;
        end
        function setWavelength(obj,wavelength)
            obj.ex.wavelength = wavelength;
        end
        function wavelength = getWavelength(obj)
            wavelength = obj.ex.wavelength;
        end
        function setMicroscopeDistances(obj,distanceObject2Diffuser,distanceDiffuser2Detector)
            obj.ex.distanceObject2Diffuser = distanceObject2Diffuser;
            obj.ex.distanceDiffuser2Detector = distanceDiffuser2Detector;
        end
        function [distanceObject2Diffuser,distanceDiffuser2Detector] = getMicroscopeDistances(obj)
            distanceObject2Diffuser = obj.ex.distanceObject2Diffuser;
            distanceDiffuser2Detector = obj.ex.distanceDiffuser2Detector;
        end
        function setImageData(obj,imageData)
            obj.ex.dataDiffraction = imageData;
        end
        function imageFrame = getImageFrame(obj,frameNum)
            imageFrame = obj.ex.dataDiffraction(:,:,frameNum);
        end
        function runPtych(obj)
            cpm = matCPM(obj.ex,obj.wv,obj.df);
            
            cpm.updateDiffuser = 1;
            cpm.updateWave = 1;
            cpm.averageOverWavelengthsDiffuser = 1;
            
            cpm.numberOfOverlapConstraintIterations = 2;
            cpm.stepSizeDiffuser = 1;
            cpm.stepSizeWave = 1;
            cpm.reflectionDepth = 1;
            cpm.beta = 0.9;
            
            %% Reconstruction Loop
            cpm.numberOfIterations = 15000;
            figure('Color','w','Units','normalized','Position',[0.25,0.25,0.5,0.5]); drawnow;
            nRows=2;
            nCols = obj.ex.numberOfWavelengths+2;
            for n = 1:cpm.numberOfIterations
            
                cpm.RAAR_M_matCPM;
                
                if mod(cpm.iterationNumber,25)==0
                    
                    object = obj.wv.propagateField(cpm.dataWave,-1);
                    
                    for lambdaIdx=1:obj.ex.numberOfWavelengths
            
                        subplot(nRows,nCols,lambdaIdx)
                        imagesc(abs(object(:,:,lambdaIdx)));
                        axis xy image off;
            
                        subplot(nRows,nCols,lambdaIdx+obj.ex.numberOfWavelengths+2)
                        imagesc(angle(object(:,:,lambdaIdx)));
                        axis xy image off;
            
                    end
                    
                    subplot(nRows,nCols,obj.ex.numberOfWavelengths+1)
                    imagesc(abs(cpm.dataDiffuser(:,:,1)));
                    axis xy image off;
                    
                    subplot(nRows,nCols,2*obj.ex.numberOfWavelengths+3)
                    imagesc(angle(cpm.dataDiffuser(:,:,1)));
                    axis xy image off;
                    
                    subplot(nRows,nCols,[obj.ex.numberOfWavelengths+2,2*(obj.ex.numberOfWavelengths+2)])
                    semilogy(cpm.totalError);
                    axis tight; pbaspect([1,2,1]);
                    title('log - Error','Interpreter','latex');
                    
                    drawnow;
                    
                    if strcmp(get(gcf,'currentCharacter'),char(8)), break; end
                    
                end
            
            end
                
        end
    end


end
