%% UCSB ECE178 (2017 Fall)
% HW4 MATLAB PART 1 - Fourier Analysis of Images
%% Image credits
% nFF1x18.jpg: "Abstract Sketch Texture" by somadjinn on 
% rgbstock,com, used under RGBStock.com license
%% For students to complete
% my_dft_2D.m, gen_fourier_basis.m, get_recon_image.m,
% creat_recon_video.m
%% Clear up previous stuff
clc
clear 
close all
%% Load the input image
input_img = imread('../test_img.png');
input_img = imresize(input_img, [100 100]);
[M,N] = size(input_img);
% Display the original input images
figure(1), imshow(input_img);axis off;
%% Get the coefficients for the Fourier basis by taking DFT/FFT
F = my_dft_2D(input_img);
F_abs = abs(F); % Fourier Coefficients
%% Order the Fourier coefficients
F_columnwise = F_abs(:);
[F_sort_columnwise, ordering] = sort(F_columnwise,'descend');
%% Now find corresponding Fourier basis and reconstruct image one by one
col = ceil(ordering/M); % col and row are the row and column indices of the ordering we just did
row = ordering - (col-1)*M;
for idx=1:(M*N)
    fprintf('On the %d fourier basis \n',idx);
    p = row(idx)-1; q = col(idx)-1; % p and q are row and col indices offset by -1 for ease of calculations
    Recon.basis{idx} = gen_fourier_basis(input_img,p,q);
    if idx==1
        Recon.image{idx} = get_recon_image(M,N,F,Recon.basis{idx},p,q);
    else
        Recon.image{idx} = Recon.image{idx-1} + get_recon_image(M,N,F,Recon.basis{idx},p,q);
    end
end
%% Create a video similar to 'fftanimation.mov'(supplied)
create_recon_video(Recon);