tic
imaqreset;

stepper = stepperController(50);
camera = sonyDMM37UX226;
imgUtil = imageSaving;
toc

tic
camera.initialize();
takeSampleUtil.setup(imgUtil,"TestApril5_5x5");
toc

takeSampleUtil.sampleAndImg(stepper,camera,imgUtil,100,500,500);

takeSampleUtil.showImage(imgUtil);

imaqreset;