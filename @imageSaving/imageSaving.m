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
                this.fullFilePath = "Executables\ImageFiles\"+ this.sampleFolder + "\Image" + this.index + ".png";
            elseif nargin == 2
                this.fullFilePath = "Executables\ImageFiles\"+ this.sampleFolder + "\Image" + varargin{1} + ".png";
            else 
                error("setFilePath requires one or two arguments only")
            end
        end

        function setIndex(this)
            i = 0;
            imgExists = true;
            while imgExists
                this.setFullFilePath(i);
                if exist(this.fullFilePath,"file") == 2
                    i = i + 1;
                else
                    imgExists = false;
                end
            end
            this.index = num2str(i);
        end

        function setImage(this,cameraObject)
            this.image = cameraObject.dataImage./(256^2);
        end

        function saveImage(this)
            imagesc(this.image);
            imwrite(this.image,this.fullFilePath,"BitDepth",16);
        end

    end

end
