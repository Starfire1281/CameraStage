classdef imageSaving < handle
    
    properties
        image           % single image matrix loaded from sonyDMM37UX226 camera
        sampleFolder    % folder for each sample
        fullFilePath    %full file path for sample
        index           %smallest unused index of sample image folder
    end

    methods
        function this = imageSaving()
        end

        function setSampleFolder(this,varargin)
            if nargin == 1
                % uigetfile
                % uigetdir
                temp = input("Please input desired image-folder","s");
            elseif nargin == 2
                temp = varargin{1};
            else
                error("setSampleFolder requires (handle) or (handle + folder name) inputs only")
            end
            this.sampleFolder = temp;
            mkdir("ImageFiles\"+this.sampleFolder);

        end
        
        function setFullFilePath(this,varargin)
            if nargin == 1
                this.fullFilePath = ".\ImageFiles\"+ this.sampleFolder + "\Image" + this.index + ".bmp";
            elseif nargin == 2
                disp(nargin)
                this.fullFilePath = ".\ImageFiles\"+ this.sampleFolder + "\Image" + varargin{1} + ".bmp";
            else 
                error("setFilePath requires one or two arguments only")
            end
        end

        function setIndex(this)
            i = 0;
            imgExists = True;
            while imgExists
                if exist(this.fullFilePath,"file") == 2
                    i = i + 1;
                    imgExists = True;
                else
                    imgExists = False;
                end
            end
            this.index = num2str(i);
        end

        function setImage(this,cameraObject)
            this.image = cameraObject.dataImage;
        end

        function saveImage(this)
            imwrite(this.image,this.fullFilePath);
        end

    end

end
