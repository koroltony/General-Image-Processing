%% UCSB ECE178 (2017 Fall)
% HW3 MATLAB - 2D Convolution and Image Transform

%% Image credits (from Flickr)
% Leopard.jpg: "Profile of a leopard" by Tambako The Jaguar, used under CC 

%% Clear up previous stuff
clc
clear 
close all

%% Load the input image
input_img = imresize(imread('Leopard.jpg'), 0.4);

% Display the original input images
imshow(input_img);

% Display the original input images (grayscale)
input_img_gray = rgb2gray(input_img);
figure,
subplot(1,2,1), subimage(input_img_gray);
title('original image (gray scale)')



%% %%%%%%%%%%%%%%%% PART 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate noisy input image
s = 20; %standard deviation of artificial noise
% generate noisy image by adding gaussian noise
noisy_img = double(input_img_gray) + s*randn(size(input_img_gray));
% round the pixel values, bring them in the range [0 255] and convert to double format
noisy_img = double(uint8(noisy_img)); 
subplot(1,2,2), subimage(uint8(noisy_img));
title('noisy image')

%% Create Gaussian filter kernel
filterSize = [3,3; 15,15];
paddingMethod = {'repeating', 'mirroring', 'zero-padding'};

gsnFilter1 = myGaussianFilter(filterSize(1,1),filterSize(1,2),0,2);
gsnFilter2 = myGaussianFilter(filterSize(2,1),filterSize(2,2),0,2);

%% Denoising using generated Gaussian filter kernels
GaussianDenoisedImgs = cell(2,3);
for method = 1:3 % generate results using different padding method
    GaussianDenoisedImgs{1,method} = uint8(myConv2(noisy_img,gsnFilter1,paddingMethod{method}));
    GaussianDenoisedImgs{2,method} = uint8(myConv2(noisy_img,gsnFilter2,paddingMethod{method}));
    display2images(GaussianDenoisedImgs(:,method),paddingMethod{method})
end

%% Denoising using bilateral filtering
w = 20;
sigma_d = [3, 10];
sigma_r = [30, 100];

BilateralDenoisedImgs = cell(2,1);
BilateralDenoisedImgs{1,1} = uint8(myBilateralFilter(noisy_img,w,sigma_d(1),sigma_r(1)));
BilateralDenoisedImgs{2,1} = uint8(myBilateralFilter(noisy_img,w,sigma_d(2),sigma_r(2)));

display2images(BilateralDenoisedImgs(:,1),'bilateral filter')



%% %%%%%%%%%%%%%%%% PART 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DCT Transform
[M,N] = size(input_img_gray);
dctImg = myDCT_Transform(double(input_img_gray));
rImg = myIDCT_Transform(dctImg);
figure,
subplot(1,2,1), subimage(uint8(dctImg));
title('DCT Transformed Image')

subplot(1,2,2), subimage(uint8(rImg));
title('Recovered Image')
