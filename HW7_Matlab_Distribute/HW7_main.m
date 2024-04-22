clear,
close all
clc
%% load the image and calculate the energy map
img = imread('lake.jpg');
Img_d = double(img)/255;
EMap = myEnergyFunc(Img_d,0,0,0);
figure,
imshow(EMap)
title('Energy Map')

%% resize the image
rC = 200;
rR = 0;
tic
rImg = mySeamCarveResize(Img_d,rC,rR);
toc
figure,
imshow(rImg)
