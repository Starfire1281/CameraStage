% vid = videoinput('winvideo',1,'Y16 _1920x1080')
% src = getselectedsource(vid);
% set(src,'FrameRate','15.0000');
% set(src,'Exposure',0.001);
% set(vid,'FramesPerTrigger',1)
% % obj = imaq.VideoDevice('winvideo',1)
% 
% %img = getsnapshot(vid);
% %imshow(img)


camera = sonyDMM37UX226;
camera.initialize;

camera.exposureTime = 0.001;

subplot(1,2,1)
tic
camera.grabImage;
imagesc(camera.dataImage);
axis xy image off;
toc

subplot(1,2,2)
tic
camera.grabImage;
imagesc(camera.dataImage.^0.25);
axis xy image off;
toc


camera.uninitialize;