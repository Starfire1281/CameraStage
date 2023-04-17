%% Setup impross
impross = imageProcessing();
impross.setDimensionsData(1080,1920);
impross.loadImageDataFromFile('./Executables/ImageFiles/TestApril7th_0.36_4x4MultiPic');
image1 = impross.getImageFrame(28);
image2 = impross.getImageFrame(29);
%% Normalize data
image2norm = impross.normImageRelative(29,28);
imshow([image1/(2^16),image2norm/(2^16)]);
%% Find image difference
diffImage = int16(image2norm)-int16(image1);
imshow([image1/(2^16),image2norm/(2^16),((diffImage).^2)/(2^32)]);
% imdiff = int16(image1/2)-unt16(image2/2)