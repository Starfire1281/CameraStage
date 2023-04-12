close all;

i1 = double(imread("Image3.png"));
i2 = double(imread("Image22.png"));

% i2(100,500)=0;
% i1(50,100)=0;
% for i = 1:size(i1)-4
%     i3(i,:)= i1(i+4,:);
% end
% imagesc(i2)
% figure()
% imagesc(fi1)

[x,y]=findShift2Images(i1,i2)

