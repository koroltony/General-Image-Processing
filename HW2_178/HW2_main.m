%% UCSB ECE178 (2017 Fall)
% HW2 MATLAB - Histogram Equalization

%% Image credits (from Flickr)
% UCSB_gate.jpg: "MobyDuckHenley 002" by UC Santa Barbara Library, used under CC
% statue_of_liberty.jpg: "Statue of Liberty 3" by gmg_660, used under CC 
% Leopard.jpg: "Profile of a leopard" by Tambako The Jaguar, used under CC 
% storke_tower.jpg: "storke tower" by greentleaf, used under CC

%% Clear up previous stuff
clc
clear all
close all

%% Load the input image
input_imgs = cell(4);
input_imgs{1} = imread('statue_of_liberty.jpg');
input_imgs{2} = imread('Leopard.jpg');
input_imgs{3} = imread('UCSB_gate.jpg');
input_imgs{4} = imread('storke_tower.jpg');

% Display the original input images
display4images(input_imgs, 'Original input images');

%  Display the original input images (grayscale)
input_imgs_gray = cell(4);
for i=1:4
    input_imgs_gray{i} = rgb2gray(input_imgs{i});
end
display4images(input_imgs_gray, 'Original input images (grayscale)');
%% Get low contrast images
test_imgs = cell(4); %These are test images
test_imgs{1} = uint8(input_imgs_gray{1}/4); %Low contrast
test_imgs{2} = uint8(input_imgs_gray{2}/4+ 96); %Low contrast
test_imgs{3} = input_imgs_gray{3}; %Bimodal histogram
test_imgs{4} = input_imgs_gray{4}; %Bimodal histogram

% Display the low constrast images
display4images(test_imgs, 'Test images (grayscale)');

% Display the bin histograms
display4hist(test_imgs, 'MATLAB Histogram of test images');

% write function to display histogram of images
for i=1:4
    plotMyHistogram(test_imgs{i},256);
end


%% Histogram equalization
% Simple scaling
output_imgs_simple_scaling = cell(4);
output_imgs_simple_scaling{1} = linearStretching(test_imgs{1}, 0, 0+63);
output_imgs_simple_scaling{2} = linearStretching(test_imgs{2}, 96, 96+63);
output_imgs_simple_scaling{3} = linearStretching(test_imgs{3}, 0, 0+63); %Artifact shows in this case
output_imgs_simple_scaling{4} = linearStretching(test_imgs{4}, 128, 128+63); %Artifact shows in this case

% Display the results by simple scaling
display4images(output_imgs_simple_scaling, 'Results by linear stretching');

% CDF method
output_imgs_CDF_method = cell(4);
for i=1:4
    output_imgs_CDF_method{i} = CDFmethod(test_imgs{i});
end
display4images(output_imgs_CDF_method, 'Results by CDF method');



