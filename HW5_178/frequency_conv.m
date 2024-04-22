function output_img = frequency_conv(input_img, conv_kernel)
% input_img: type double
% conv_kernel: type double
% output_img: type double, size same as input_img
%% Write your function here
kernel_dim = size(conv_kernel);

% create padding regions for input image
vertical_pad = (kernel_dim(1)-1)/2;
horizontal_pad = (kernel_dim(2)-1)/2;

% find dimensions of input image to create kernel pad
img_dim = size(input_img);
height = img_dim(1);
width = img_dim(2);

% fill kernel with 0 for size of image and then add the input kernel
padded_kernel = zeros(height, width);
padded_kernel(1:kernel_dim(1), 1:kernel_dim(2)) = conv_kernel;

% calculate fft of both kernel and image
img_freq = my_fft_2D(input_img);
kernel_freq = my_fft_2D(padded_kernel);

% perform dot product and inverse fft
result = ifft2(img_freq.*kernel_freq);

% circularly shift the output by the padding amount to shift image
% back to its original coordinates
output_img = circshift(result,[-vertical_pad -horizontal_pad]);

end