classdef stepperController < handle 

    properties
      %The activeX controller
      activeXcontroller
      %Serial number of our motor controller
      SN
      %The size of the region we want to take an image of, currently in
      %steps
      regionX
      regionY
      normRegX
      normRegY
      %Current x and y position (In steps)
      %xStep
      %yStep
      %Current x and y position in real space
      x
      y
      %Real space limit's of stage
      Xlength = 20;
      Ylength = 20;
      %figure for activex controller
      f
   end
   methods (Access = public)
        %Constructor
        function this = stepperController(stepSize)
            %Set parameters for, and instanciate GUI we'll never use
            fpos    = get(0,'DefaultFigurePosition'); % figure default position
            fpos(3) = 650; % figure window size;Width
            fpos(4) = 450; % Height
            this.f = figure('Position', fpos,...
           'Menu','None',...
           'Name','APT GUI');
        
            %Instanciate the controller itself
            this.activeXcontroller = actxcontrol('APTPZMOTOR.APTPZMotorCtrl.1',[20 20 600 400 ], this.f, {'MoveComplete' 'MoveCompleteHandler'; 'MoveStopped' 'MoveStoppedHandler'}); %#ok<ACTXC> 
            %Make it start controlling
            this.activeXcontroller.StartCtrl;
            %Give it the serial number of our driver (change the number if hardware changes)
            this.SN = 97101743; % Mr Morale
            %this.SN = 97101761; % Ms Malevolent

            set(this.activeXcontroller,'HWSerialNum', this.SN);
            %Blink driver light
            this.activeXcontroller.Identify;

            % Events 
            % registerevent does the same thing as instantiating the event in the actxcontrol sequence on ln36
            %this.h.registerevent({'MoveComplete' @MoveHandler});
            %this.h.isevent('HWResponse') %is testing to see if the event actually exists
            
            %Shows us the methods of our activeXcontroller
            %this.h.methods()

            %Wait for gui to load
            pause(3);
            
            %Set our class variables
            this.activeXcontroller.SetJogStepSize(1,stepSize);
            this.activeXcontroller.SetJogStepSize(2,stepSize);
        end
        %Moves the motor connected to channel channel through this controler, stepSize steps, in the direction direction
        %Note, direction can be 1 or 2
        %Channel 0 is X channel 1 is Y
        function moveSampleArray(this,stepSize,channel,direction)
            %global Movevar
            this.activeXcontroller.SetJogStepSize(channel,stepSize);
            this.activeXcontroller.MoveJog(channel,direction);
            %Movevar = true;
            setMovevar(true);
            t=0;
            while 1
                if getMovevar() == 0
                    break
                end
                if t == 100000
                    break
                end
                t= t+1;
            end
        end
        
        %Character eased move
        function moveSampleChar(this,stepSize,charDir)
            [channel,direction] = dirChar(charDir);
            moveSampleArray(this,stepSize,channel,direction);
            pause(1);
        end
        %Set move size in steps
        function setMoveSizeSteps(this,stepSize)
            this.activeXcontroller.SetJogStepSize(channel,stepSize);
        end
        %Just move without changing step size
        function simpleMove(this,charDir)
            [channel,direction] = dirChar(charDir);
            moveSampleArray(this,channel,direction);
        end
        %Sets the x and y size of the region of sample movenment we want to take a picture of, in number of total steps directly
        function setRegionSizeSteps(this,x,y)
            this.regionY = y;
            this.regionX = x;
        end
        function setRegionSizeNorm(this,x,y,steps)
            this.normRegY = ceil(y/(steps));
            this.normRegX = ceil(x/(steps))-1;
        end

        %Sets the x and y size of the region of sample movenment we want to take a picture of, in number of total steps, however from real space distance
        %function SetRegionSizeSteps(this,)
% 
%         for i=1:ceil(stepper.regionY/(2*stepSize))
%                 if i ~= 1
%                     stepper.MoveSampleChar(stepSize,'d')
%                     pause(1);
%                     Grab;
%                 else 
%                     Grab;
%                 end
%                 
%                 for j=1:(ceil(stepper.regionX/stepSize)-1)
%                     MoveSampleChar(stepper,2*stepSize,'l')
%                     MoveSampleChar(stepper,2*stepSize,'l')
%                     MoveSampleChar(stepper,stepSize,'l')
%                     pause(1);
%                     Grab; %Saves images in ImageFiles folder
%                 end
%                 MoveSampleChar(stepper,stepSize,'d')
%                 pause(1);
%                 Grab;
%                 for j=1:(ceil(stepper.regionX/stepSize)-1)
%                     MoveSampleChar(stepper,stepSize,'r')
%                     pause(1);
%                     Grab;
%                 end
%             end
%             disp("Move sequence completed")
%         end
   end
end