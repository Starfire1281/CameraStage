tic
imaqreset;

stepper = stepperController(50);
camera = sonyDMM37UX226;
imgUtil = imageSaving;
toc

tic
camera.initialize(2); %Only real change
takeSampleUtil.setup(imgUtil,"TestApril7th_0.36_4x4MP");
toc

takeSampleUtil.sampleAndImg(stepper,camera,imgUtil,100,400,400);

takeSampleUtil.showImage(imgUtil);

imaqreset;