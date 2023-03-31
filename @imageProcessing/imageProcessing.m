classdef imageProcessing < handle
    % This class is intended to process our image information received from
    % StepperController presumably via a file, and throw it through Dan's
    % software

    % This is only built to handle one image set at a time, so each object
    % should have a different set of images

    %TODO: Figure out how to map out the original path.

    properties (Access = private)%cuz I have nice getters and setters
        %The experimental parameters, this includes images and distances
        ex;
        %UnitConstant object
        u;
        %The assocciated shifts
        pixelShifts;
        %Number of photos
        numImages;
    end
    
    methods (Access = public)
        % The intention is to make this object once for a given run, then modify what data it
        % has.
        function obj = imageProcessing(varargin)
            switch nargin
                case 0
                    %   Make an empty imageProcessing object to modify later
                    createExperiment(obj);
                case 5
                    %   Create one using everything!
                    %dimensionsDataX (pixel size of detector),detectorPixelSize (actual size of each pixel),lambda,distanceObject2Diffuser,distanceDiffuser2Detector
                    createExperiment(obj,varargin{1},varargin{2},varargin{3},varargin{4},varargin{5})
                otherwise
                    disp(nargin)
                    error('ImageProcessing accepts 0 or 5 input arguments!')
            end
        end


        %Load An Image Set Into Our Image Processing Object
        function loadImageDataFromFile(obj)
            disp("Please select the folder you would like to load images from");
            imagesPath = uigetdir("./ImageFiles");
            imageFiles = dir([imagesPath '/*.bmp']);
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
            obj.pixelShifts = zeros(2,obj.numImages-1);
            image1 = obj.getImageFrame(1);
            for i = 2:(obj.numImages)
                image2 = obj.getImageFrame(i);
                [obj.pixelShifts(1,i-1),obj.pixelShifts(2,i-1)] = findShift2Images(image1,image2);
            end
        end

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
            wavelength = obj.ex.wavelength
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
    end

    methods (Access = private)
        function createExperiment(obj,varargin)
            %Regardless set up experiment and units
            obj.ex = experiment();
            obj.u = unitsConstants.unitsSI;
            switch nargin
                %Room for extra cases
                case 1
                case 6
                    %dimensionsData (pixel size of detector),detectorPixelSize (actual size of each pixel),lambda,distanceObject2Diffuser,distanceDiffuser2Detector
                    obj.ex = experiment();
                    obj.u = unitsConstants.unitsSI;
                    %Set camera parameters
                    obj.setDimensionsData(varargin{1}(1),varargin{1}(2));
                    obj.setDetectorPixelSize(varargin{2}(1),varargin{2}(2));
                    obj.setWavelength(varargin{3});
                    obj.setMicroscopeDistances(varargin{4},varargin{5});
                otherwise
                    error('createExperiment accepts 1 or 5 input arguments!')
            end
        end
    end
end

