%Instanciate stepper motor
controller=StepperController(50);
%Try functions

%MoveAlongRegion(controller,100,500)

%Move Stage Down, up, left, then right.
%MoveSampleChar(controller,100,'d');
%pause(0.5)
%MoveSampleChar(controller,100,'u');
%pause(2)
%MoveSampleChar(controller,500,'l');
%pause(2)
%MoveSampleChar(controller,500,'r');
MoveSampleChar(controller,500,'d');

%Callibrate stages

%Get position, absolute

%Take picture 

%Set path/dimentions of requested image

%Kit cat and cabootle (step and take pictures)

%Let user move the stage manually (GUI)