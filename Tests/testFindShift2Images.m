%This script is to check that findShift2Images works as expected
%If we have an even gridsize
Neven = 128;
evenTestShift = [10,-5];
[x,y]=meshgrid(-1/2:1/Neven:1/2-1/Neven);
f = exp(-(x.^2 + y.^2)/0.05^2);
g = circshift(f,evenTestShift);
[xShift,yShift] = findShift2Images(f,g);
if evenTestShift == [xShift,yShift]
    disp("Even shift test SUCCESS");
else
    disp("Even shift test FAILED");
end

Nodd = 121;
oddNegTestShift = [-8,-3];
[x,y]=meshgrid(-1/2:1/Nodd:1/2-1/Nodd);
f = exp(-(x.^2 + y.^2)/0.05^2);
g = circshift(f,oddNegTestShift);
[xShift,yShift] = findShift2Images(f,g);
if oddNegTestShift == [xShift,yShift]
    disp("Odd negative shift test SUCCESS");
else
    disp("Odd negative shift test FAILED");
end

oddPosTestShift = [6,1];
[x,y]=meshgrid(-1/2:1/Nodd:1/2-1/Nodd);
f = exp(-(x.^2 + y.^2)/0.05^2);
g = circshift(f,oddPosTestShift);
[xShift,yShift] = findShift2Images(f,g);
if oddPosTestShift == [xShift,yShift]
    disp("Odd positive shift test SUCCESS");
else
    disp("Odd positive shift test FAILED");
end

imageX = 2160;
imageY = 3840;
bigShift = [-887,56];

[x,y]=meshgrid(-1/2:1/imageX:1/2-1/imageY);
f = exp(-(x.^2 + y.^2)/0.05^2);
g = circshift(f,bigShift);
[xShift,yShift] = findShift2Images(f,g);
if bigShift == [xShift,yShift]
    disp("Image size shift test SUCCESS");
else
    disp("Image size shift test FAILED");
end
