tic
imaqreset;

stepper = stepperController(50);
camera = sonyDMM37UX226;
imgUtil = imageSaving;
toc

tic
camera.initialize();
takeSampleUtil.setup(imgUtil,"DiffuserOnly4x4_April12");
toc

takeSampleUtil.sampleAndImg(stepper,camera,imgUtil,100,400,400);

takeSampleUtil.showImage(imgUtil);

imaqreset;