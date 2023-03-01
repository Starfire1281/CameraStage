%Iterate through images in folder
disp("Please enter the name of the folder you would like to convolve");
imagesPath = uigetdir("./ImageFiles");
imageFiles = files(imagesPath);
for x = 1:length(files);
myFun(f[x]);
end