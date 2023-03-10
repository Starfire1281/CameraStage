classdef ImageProcessing < handle
    % This class is intended to process our image information received from
    % StepperController presumably via a file, and throw it through Dan's
    % software

    % This is only built to handle one image set at a time, so each object
    % should have a different set of images

    %TODO: Figure out how to map out the original path.

    properties
        %The experimental parameters, this includes images and distances
        ex;
        %UnitConstant object
        u;
        %The assocciated shifts
        pixelShifts;
        %Camera pixle sizes
        imageX;
        imageY;
        %Number of photos
        numImages;
    end
    
    methods (Access = public)
        % The intention is to make this object once for a given run, then modify what data it
        % has.
        function obj = ImageProcessing()
            %   Make an empty imageProcessing object to modify later
            createExperiment(obj);
        end


        %Load An Image Set Into Our Image Processing Object
        function loadImageDataFromFile(obj)
            disp("Please select the folder you would like to load images from");
            imagesPath = uigetdir("./ImageFiles");
            imageFiles = dir([imagesPath '/*.bmp']);
            obj.numImages = length(imageFiles);
            imageData = zeros(obj.imageX,obj.imageY,obj.numImages);
            for i = 1:(obj.numImages)
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
        %Image data
        function setCameraPixels(obj,xSize,ySize)
            %Camera pixle sizes
            obj.imageX = xSize;
            obj.imageY = ySize;
        end
        function [xSize,ySize] = getCameraPixels(obj)
            %Camera pixle sizes
            xSize = obj.imageX;
            ySize = obj.imageY;
        end
        function setImageData(obj,imageData)
            obj.ex.dataDiffraction = imageData;
        end
        function imageFrame = getImageFrame(obj,frameNum)
            imageFrame = obj.ex.dataDiffraction(:,:,frameNum);
        end
    end

    methods (Access = private)
        function createExperiment(obj)
            %Make objects from dan's code for experiment and to have nice
            obj.ex = experiment();
            %units
            obj.u = unitsConstants.unitsSI;
            %Set pixel sizes
            obj.setCameraPixels(2160,3840);
        end
    end
end

