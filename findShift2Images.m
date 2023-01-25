%Finds corrilation in 2D between 2 same sized images
function [xShift,yShift] = findShift2Images(a,b)

% Things to add:
% Sepereate out nfft2 alh nifft2 functions


    [M,N]=size(a);

    A = nfft2(a);
    B = nfft2(b);

    CC = abs( nifft2(A.*conj(B)) );
    imagesc(CC)

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