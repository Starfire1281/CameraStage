classdef StepperController < handle
   properties
      %The activeX controller
      activeXcontroller
      %Serial number of our motor controller
      SN
      %The size of the region we want to take an image of, currently in
      %steps
      regionX
      regionY
      %Current x and y position (In steps)
      %xStep
      %yStep
      %Current x and y position in real space
      x
      y
      %Real space limit's of stage
      Xlength = 20;
      Ylength = 20;
   end
   methods (Access = public)
        %Constructor
        function this = StepperController(stepSize)
            %Set parameters for, and instanciate GUI we'll never use
            fpos    = get(0,'DefaultFigurePosition'); % figure default position
            fpos(3) = 650; % figure window size;Width
            fpos(4) = 450; % Height
            f = figure('Position', fpos,...
           'Menu','None',...
           'Name','APT GUI');
        
            %Instanciate the controller itself
            this.activeXcontroller = actxcontrol('APTPZMOTOR.APTPZMotorCtrl.1',[20 20 600 400 ], f, {'MoveComplete' 'MoveCompleteHandler'; 'MoveStopped' 'MoveStoppedHandler'});
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
            
            %Shows us the meathods of our activeXcontroller
            %this.h.methods()

            %Wait for gui to load
            pause(3);
            
            %Set our class variables
            this.activeXcontroller.SetJogStepSize(1,stepSize)
            this.activeXcontroller.SetJogStepSize(2,stepSize)
        end
        %Moves the motor connected to channel channel through this controler, stepSize steps, in the direction direction
        %Note, direction can be 1 or 2
        %Channel 0 is X channel 1 is Y
        function MoveSampleArray(this,stepSize,channel,direction)
            %global Movevar
            this.activeXcontroller.SetJogStepSize(channel,stepSize)
            this.activeXcontroller.MoveJog(channel,direction)
            %Movevar = true;
            setMovevar(true)
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
        function MoveSampleChar(this,stepSize,charDir)
            [channel,direction] = dirChar(charDir)
            MoveSampleArray(this,stepSize,channel,direction)
            pause(0.5);
        end
        %Set move size in steps
        function SetMoveSizeSteps(this,stepSize,charDir)
            this.activeXcontroller.SetJogStepSize(channel,stepSize);
        end
        %Just move without changing step size
        function SimpleMove(this,charDir)
            [channel,direction] = dirChar(charDir)
            MoveSampleArray(this,channel,direction)
        end
        %Sets the x and y size of the region of sample movenment we want to take a picture of, in number of total steps directly
        function SetRegionSizeSteps(this,x,y)
            this.regionY = y
            this.regionX = x
        end
        %Sets the x and y size of the region of sample movenment we want to take a picture of, in number of total steps, however from real space distance
        %function SetRegionSizeSteps(this,)
        %Moves the stepper in a zig-zag along the x and y axis
        function MoveAlongRegion(this,stepSize,regionSize)
            disp(stepSize)
            disp("Moving through sample region...")
            %Region is in step size. 
            %Can adjust to physical measurements later on once calibrating is setup
            this.regionX = regionSize;
            this.regionY = regionSize;
            
            %Starts one step above the sample region, then moves: 
            %down, left, down, right, taking images after each movement 
            %until the full range of the sample is traveled
            for i=1:ceil(this.regionY/(2*stepSize))
                if i ~= 1
                    MoveSampleChar(this,stepSize,'d')
                    pause(1);
                    Grab;
                else 
                    Grab;
                end
                
                for j=1:(ceil(this.regionX/stepSize)-1)
                    MoveSampleChar(this,2*stepSize,'l')
                    MoveSampleChar(this,2*stepSize,'l')
                    MoveSampleChar(this,stepSize,'l')
                    pause(1);
                    Grab; %Saves images in ImageFiles folder
                end
                MoveSampleChar(this,stepSize,'d')
                pause(1);
                Grab;
                for j=1:(ceil(this.regionX/stepSize)-1)
                    MoveSampleChar(this,stepSize,'r')
                    pause(1);
                    Grab;
                end
            end
            disp("Move sequence completed")
        end
   end
end