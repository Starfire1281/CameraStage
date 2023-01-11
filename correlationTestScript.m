clc;
close all;

[parameters,probe,object] = simulatePtychographyScan;
reconstructionTest = matPty(parameters,object,probe)

disp(class(reconstructionTest))


% using the images obtained previously, resize to probe size from
% Reconstruction object
windowFcn = abs(reconstructionTest.dataProbe);
windowFcn = 1-windowFcn/max(abs(windowFcn(:)));


img0 = imread('ImageFiles\Image0.bmp');
img1 = imread('ImageFiles\Image1.bmp');

img0 = im2double(img0);
img1 = im2double(img1);
%disp("window fcn length")
length(windowFcn);
smallImg0 = zeros(length(windowFcn),length(windowFcn));
smallImg1 = zeros(length(windowFcn),length(windowFcn));
%disp("smImg1 size");
size(smallImg1);

for i = 1:(32)
    for j = 1:(32)
        %disp(i);
        %disp(j);
        smallImg0(i,j) = img0(i,j);
        smallImg1(i,j) = img1(i,j);
        size(smallImg1);
    end
end
%disp("window fcn & SmImg1 length");
size(windowFcn);
size(smallImg0);

%run cross correlation matpty method
test = upsampledCrossCorrelation(reconstructionTest,img1,img1)