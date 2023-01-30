%This makes an experiment for our uses from Dan's code:
ex = experiment();


% import units and physical constants
u = unitsConstants.unitsSI;

%% make Experiment


path2Images = "../ImageFiles";
imageX = 2160;
imageY = 3840;

%Load pictures into experiment
imageFiles=dir(path2Images);
imageNum = (length(imageFiles)/2)-1;
imageData = zeros(length(imageFiles),imageX,imageY);
imagePositions = zeros(length(imageFiles),2);
for i=1:imageNum
    image1 = imread(strcat(path2Images,"/image",string(i-1),".bmp"));
    imageData(i,:,:) = image1;
    if (i ~= 1)
        image2 = imread(strcat(path2Images,"/image",string(i-2),".bmp"));
        twoDshift = findShift2Images(image1,image2);
        imagePositions(i,:,:) = twoDshift + imagePositions(i-1,:,:);
    else
        imagePositions(i,:,:) = [0,0];
    end
end
ex.dataDiffraction = imageData;

ex.positionsX = imagePositions(:,1);
ex.positionsY = imagePositions(:,2);

ex.numberOfPositions = 12;
ex.numberOfWavelengths = 1;
        
ex.reconstructedPixelSizeX = imageX;
ex.reconstructedPixelSizeY = imageY;

ex.distanceObject2Diffuser = 21 * u.mm;
ex.distanceDiffuser2Detector = 201.5 * u.mm;

ex.detectorPixelSizeX = imageX;
ex.detectorPixelSizeY = imageY;

ex.dimensionsDataX = imageX;
ex.dimensionsDataY = imageY;

%% make diffuser -------------------------------------------------------- %
df = diffuserClass(ex);
%% make object ---------------------------------------------------------- %
wv = waveClass(ex);