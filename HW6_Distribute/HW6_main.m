%% UCSB ECE178 Fall 2016 Homework 5
clc
clear 
close all

%% Part 1
% Load the input image
input_img = imread('barbara_512.png');
% Set the anti-aliasing method
downsampled.AAmethod = {'No Filtering', 'Box filter', 'Gaussian'};
downsampled.original_img = input_img;
% Proper low pass filter is gaussian in this case
for method = 1:3
    downsampled.img{method} = uint8(myDownSampling(input_img, 3, downsampled.AAmethod{method}));
%     figure
%     imshow(downsampled.img{method});
%     title(['AntiAliasing:' downsampled.AAmethod{method}])
end
display3images(downsampled.img, 'Downsampled', downsampled.AAmethod)

%% Part 2

img = double(imread('barbara_512.png'));
PSF = fspecial('motion',20,90);

RL_blur = cell(3,1);
RL_blur{1} = uint8(img);
RL_blur{2} = uint8(conv2(img, PSF, 'same'));
iter = 25;
RL_blur{3} = uint8(myRichardsonLucy(RL_blur{2},PSF,iter));
display3images(RL_blur,'RichardsonLucy',{'Original Image','Motion Blur','Recovered'})