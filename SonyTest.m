%
%vid = videoinput('winvideo','2','Y16 _3840x2160')
% src = getselectedsource(vid);
% set(src,'FrameRate','15.0000');
% set(src,'Exposure',0.001);
% set(vid,'FramesPerTrigger',1)
% % obj = imaq.VideoDevice('winvideo',1)
% 
% %img = getsnapshot(vid);
% %imshow(img)

clc
%
imaqreset

camera = sonyDMM37UX226;
camera.initialize;

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