imPros = imageProcessing([1080,1920],[1,1],5,6,7);
imPros.loadImageDataFromFile();
imPros.convolveFromData();
imPros.setMicroscopeDistances(3.6125,0.5);
imPros.setWavelength(490);
imPros.setDetectorPixelSize(0.0018,0.0018);
imPros.runPtych;







