classdef takeSampleUtil
    
    
    methods(Static)
        function setup(imgSav,varargin)
            imgSav.setSampleFolder(varargin)
            imgSav.setFullFilePath(varargin)
        end

        function picAndSave(cam,imgSav)
            imgSav.setIndex();
            disp("setIndex")
            cam.grabImage();
            disp("grabImage")
            imgSav.setImage(cam);
            disp("setImage")
            imgSav.saveImage();
            disp(cam.n);
            cam.n = cam.n + 1;
        end

        function showImage(imgSav)
            imagesc(imgSav.image);
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
            disp("Set regions")


            for i = 1:stepper.normRegY
                disp("Loops Starting")
                if mod(i,2) ~= 0
                    if i == 1
                        disp("Take Picture");
                        takeSampleUtil.picAndSave(cam,imgSav);
                        disp("Finished taking picture");
                    else 
                        stepper.moveSampleChar(stepSize,'d');
                        disp("Moving Down")
                        takeSampleUtil.picAndSave(cam,imgSav);
                    end
                    for j = 1:stepper.normRegX
                    stepper.moveSampleChar(stepSize,'l');
                    disp("Moving Left");
                    takeSampleUtil.picAndSave(cam,imgSav);
                    end
                else 
                    stepper.moveSampleChar(stepSize,'d');
                    takeSampleUtil.picAndSave(cam,imgSav);
                    disp("Moving Down");
                    for j = 1:stepper.normRegX
                        stepper.moveSampleChar(stepSize,'r');
                        disp("Moving Right")
                        takeSampleUtil.picAndSave(cam,imgSav);
                    end
                end
                disp("Loop Complete");
                disp(i);
            end
            disp("Move sequence completed");
        end

    end
end