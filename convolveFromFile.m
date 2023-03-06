%Iterate through images in folder
disp("Please select the folder you would like to convolve");
imagesPath = uigetdir("./ImageFiles");
disp(imagesPath);
imageFiles = dir([imagesPath '/*.bmp']);
%convolutionsPath 

%Open file to write to
pathSplit=regexp(imagesPath,'\','split');
fileName = append(char(pathSplit(1,end)),'.txt');
fid = fopen(append(".\ConvolutionFiles\",fileName), 'wt' );
fprintf( fid, 'Yay File! \n');

for i = 1:(length(imageFiles)-1)
    image1 = imread(append(imagesPath,'\',imageFiles(i).name));
    image2 = imread(append(imagesPath,'\',imageFiles(i+1).name));
    [a1,a2] = findShift2Images(image1,image2);
    fprintf( fid, '%f,%f\n', a1, a2);
end

fclose(fid);