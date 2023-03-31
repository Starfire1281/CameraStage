imaqreset;

stepper = stepperController(50);
camera = sonyDMM37UX226;
imgUtil = imageSaving;

camera.initialize();
takeSampleUtil.setup(imgUtil,"TestMarch29");

takeSampleUtil.sampleAndImg(stepper,camera,imgUtil,100,100,100);

takeSampleUtil.showImage(imgUtil);
