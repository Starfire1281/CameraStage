function g = GaussianArrayMJG(dim,w,x0,maxVal)
    if dim == 1
        g = zeros(maxVal,2);
        for i = -maxVal:maxVal
            g(i+maxVal+1,2) = i;
            g(i+maxVal+1,1) = exp(-(i-x0).^2/w^2);
        end
    elseif dim == 2
        g = zeros(maxVal,maxVal);
        for i = -maxVal:maxVal
            for j = -maxVal:maxVal
                g(i+maxVal+1,2)= exp(-((i-x0).^2+(j-x0).^2)/w^2);
                g(i+maxVal+1,1)= exp(-((i-x0).^2+(j-x0).^2)/w^2);
            end
        end
    end
end