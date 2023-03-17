imaqreset;

stepper = StepperController(50);
camera = sonyDMM37UX226;
imgUtil = imageSaving;

camera.initialize();
takeSampleUtil.setup(imgUtil,"ActualTestFolderMarch17");

takeSampleUtil.sampleAndImg(stepper,camera,imgUtil,100,100,200);

takeSampleUtil.showImage(imgUtil);
