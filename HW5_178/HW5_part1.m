%% UCSB ECE178 (2017 Fall)
% HW5 MATLAB PART 1 - Frequency Convolution
%% Kernel credit
% kernel 4 from Levin [1]
% [1] Effi Levi: Using Natural Image Priors: Maximizing Or Sampling? Hebrew University of Jerusalem (2009), http://leibniz.cs.huji.ac.il/tr/1207.pdf
%% Image credit
% from the USC-SIPI database
%%
clear;
clc;
close all;
%% Sub-part-2: Verifying similarity of convolution operation in spatial and frequency domains
%Implement spatial_conv.m, frequency_conv.m
fprintf('HW5 part 1 \n');
input_img = imread('elaine_512.png');
% Load the kernel file
load('kernel4.mat'); 
conv_kernel = f; 
% Visualize the kernel
figure
imshow(conv_kernel./(max(conv_kernel(:))));

% Spatial convolution
conv_res_1 = spatial_conv(double(input_img), conv_kernel);
figure
imshow(uint8(conv_res_1));

% Frequency convolution
conv_res_2 = frequency_conv(double(input_img), conv_kernel);
figure
imshow(uint8(conv_res_2));
% MSE Analysis
MSE_2 = calc_MSE_2D(conv_res_1, conv_res_2);
fprintf('The MSE between the 2 convolved results is %4.3f \n',MSE_2);