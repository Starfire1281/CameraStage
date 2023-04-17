clc
imaqreset

camera = sonyDMM37UX226;
camera.initialize(2);

disp("Uhhhhh");

camera.exposureTime = 0.0000000001;

subplot(1,2,1)
tic
camera.grabImage();
imagesc(camera.dataImage);
axis xy image off;
toc

subplot(1,2,2)
tic
camera.grabImage();
imagesc(camera.dataImage.^0.25);
axis xy image off;
toc


% camera.uninitialize;