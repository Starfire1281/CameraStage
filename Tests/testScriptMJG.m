% maxVal = 200
% pulse = GaussianArrayMJG(1,5,100,maxVal);
% pulse2 = GaussianArrayMJG(1,5,25,maxVal);
% %[a,b]= max(result)
% %[a,b]= max(result2)
% 
% 
% fr = fft(pulse(:,1));
% fr2 = fft(pulse2(:,1));
% 
% 
% correlation = ifft(fr .* conj(fr2));
% 
% tempcor = correlation;
% for i = 1:maxVal
%     correlation(i) = tempcor(maxVal+i);
%     correlation(maxVal+i)=tempcor(i);
% end
% 
% figure();
% hold on 
% %xlim([-20,20]);
% plot(pulse(:,2),correlation(:,1),'Color','m')
% plot(pulse(:,2),pulse(:,1),"Color",'r')
% plot(pulse2(:,2),pulse2(:,1),'Color','k')
% legend('correlation','pulse1','pulse2')
% hold off
% [a,b] = max(correlation)
% 
% disp("diff")
% disp(pulse(b(1),2))

% set parameters for a simulated ptychography scan and create a
% reconstruction of the scanned object
[parameters,probe,object] = simulatePtychographyScan;
reconstructionTest = matPty(parameters,object,probe)

disp(class(reconstructionTest))


% using 
windowFcn = abs(reconstructionTest.dataProbe);
windowFcn = 1-windowFcn/max(abs(windowFcn(:)));


img0 = imread('ImageFiles\Image0.bmp');
img1 = imread('ImageFiles\Image1.bmp');

img0 = im2double(img0);
img1 = im2double(img1);
%disp("window fcn length")
length(windowFcn);
smallImg0 = zeros(length(windowFcn),length(windowFcn));
smallImg1 = zeros(length(windowFcn),length(windowFcn));
%disp("smImg1 size");
size(smallImg1);

for i = 1:(32)
    for j = 1:(32)
        %disp(i);
        %disp(j);
        smallImg0(i,j) = img0(i,j);
        smallImg1(i,j) = img1(i,j);
        size(smallImg1);
    end
end
%disp("window fcn & SmImg1 length");
size(windowFcn);
size(smallImg0);

test = upsampledCrossCorrelation(reconstructionTest,img1,img1)

% this = reconstruction; 
% PSIBefore = smallImg0;
% PSIAfter = smallImg1;
% 
% %windowFcn = ones(size(PSIBefore));
%     
% psiBefore = fft2(PSIBefore .* windowFcn);
% psiAfter = fft2(PSIAfter .* windowFcn);
%     
% fourierTransformProduct = fftshift(fftshift(psiBefore .* conj(psiAfter),1),2);
%     
% % zoomed cross-correlation using DIFT
% crossCorrelation = abs( mtimesx(mtimesx(this.posCorDFTCol, fourierTransformProduct), this.posCorDFTRow) );
% 

% size(fr)
% figure();
% hold on 
% plot(fr(:,2),fr(:,1))
% plot(fr2(:,2),fr2(:,1))
% hold off

% d2 = GaussianArrayMJG(2,5,0,100)
% 
% figure()
% hold on
% 
% hold off
    % zoomed cross-correlation using DIFT
%crossCorrelation = abs( mtimesx(mtimesx(this.posCorDFTCol, fourierTransformProduct), this.posCorDFTRow) );

%[a,b]=max(a)

