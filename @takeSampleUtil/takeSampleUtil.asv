classdef takeSampleUtil
    
    methods(Static)
        function setup(imgSav,varargin)
            imgSav.setSampleFolder(varargin)
            imgSav.setFullFilePath(varargin)
        end

        function picAndSave(cam,imgSav)
            imgSav.setIndex();
            cam.grabImage();
            imgSav.setImage(cam);
            imgSav.saveImage();
        end

        %Moves the stepper in a zig-zag along the x and y axis
        function sampleAndImg(stepper,cam,imgSav,stepSize,regionSizeX,regionSizeY)
            disp("Moving through sample region...")
            %Region is in same units as step size.
            %Can adjust to physical measurements later on once calibrating is setup
            stepper.setRegionSizeSteps(regionSizeX,regionSizeY);
            stepper.setRegionSizeNorm(regionSizeX,regionSizeY,stepSize)

            %Stepper moves down, left, down, right, taking images after each movement
            %until the full range of the sample is traveled


            for i = 1:stepper.normRegY
                if mod(i,2) ~= 0
                    if i == 1
                        takeSampleUtil.picAndSave(cam,imgSav);
                    else 
                        stepper.moveSampleChar(stepSize,'d');
                        takeSampleUtil.picAndSave(cam,imgSav);
                    end
                    for j = 1:stepper.normRegX
                    stepper.moveSampleChar(stepSize,'l');
                    takeSampleUtil.picAndSave(cam,imgSav);
                    end
                else 
                    stepper.moveSampleChar(stepSize,'d');
                    takeSampleUtil.picAndSave(cam,imgSav);
                    for j = 1:stepper.normRegX
                        stepper.moveSampleChar(stepSize,'l');
                        takeSampleUtil.picAndSave(cam,imgSav);
                    end
                end
            end
            disp("Move sequence completed");
        end

    end
end