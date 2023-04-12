%Finds corrilation in 2D between 2 same sized images
function [xShift,yShift] = findShift2Images(a,b)

% Things to add:
% Sepereate out nfft2 alh nifft2 functions

    a = norm2max(a);
    b = norm2max(b);

    imdiff = abs(a-b); imdiff = imdiff/max(imdiff(:));
    msk = imdiff<0.1;
    a(msk)=0.1;
    b(msk)=-0.1;

    imagesc( imdiff );

    ax1 = subplot(121);
    imagesc(a); axis image;
    ax2 = subplot(122);
    imagesc(b); axis image;
    
    linkaxes([ax1,ax2])

    [M,N]=size(a);

    A = nfft2(a);
    B = nfft2(b);

    CC = abs( nifft2(A.*conj(B)) ).^16;

    figure;
    imagesc(CC);

    [~,idx]=max(CC(:));
    [yShift,xShift] = ind2sub(size(CC),idx);
    
    %Test if N and M are even or odd and use that 
    if mod(N,2) == 0
        xShift = N/2 + 1 - xShift;
    else
        xShift = N/2 + 1.5 - xShift;
    end

    if mod(M,2) == 0
        yShift = M/2 + 1 - yShift;
    else
        yShift = M/2 + 1.5 - yShift;
    end

end

function b = nfft2(a)
    b = ifftshift(fft2(fftshift(a)));

end
function a = nifft2(b)
    a = ifftshift(ifft2(fftshift(b)));
    
end
function b = norm2max(a)

    b = (a-min(a(:)))/(max(a(:))-min(a(:)));

end