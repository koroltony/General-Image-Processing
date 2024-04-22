function [F] = my_dft_2D(input_img)
%% Calculate the Fourier coefficients for the input image
input_img = double(input_img);

dim = size(input_img);
M = dim(1); % height
N = dim(2); % width

F = zeros(M,N);

% using standard summation formula for 2d discrete fourier transform
% by doing a nested loop, you can condense the DFT into one exponential
for k = 1:M
    for l = 1:N
        for m = 1:M
            for n = 1:N
               F(k,l) = F(k,l) + input_img(m,n)*exp(-2j*pi*((k/M)*(m-1)+(l/N)*(n-1)));
            end
        end
    end
end
end