i1 = imread("Image0.png");
i2 = imread("Image2.png");

for i = 1:size(i1)-4
    i3(i,:)= i1(i+4,:);
end
imagesc(i2)
figure()
imagesc(i1)

[x,y]=findShift2Images(i1,i2)
