function [xShift,yShift] = findShift2Images(a,b)
% Example code:
% 
% N = 128;
% 
% [x,y]=meshgrid(-1/2:1/N:1/2-1/N);
% 
% f = exp(-(x.^2 + y.^2)/0.05^2);
% g = circshift(f,[10,-5]);
% 
% [xShift,yShift] = findShift2Images(f,g);
%
% Things to add:
% 
% Even odd if statement
% Sepereate out nfft2 alh nifft2 functions


    [M,N]=size(a);

    A = nfft2(a);
    B = nfft2(b);

    CC = abs( nifft2(A.*conj(B)) );

    [~,idx]=max(CC(:));
    [xShift,yShift] = ind2sub(size(CC),idx);

    xShift = N/2+1-xShift;
    yShift = M/2+1-yShift;

end

function b = nfft2(a)
    b = ifftshift(fft2(fftshift(a)));

end
function a = nifft2(b)
    a = ifftshift(ifft2(fftshift(b)));
    
end