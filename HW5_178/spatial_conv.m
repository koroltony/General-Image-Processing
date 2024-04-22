function output_img = spatial_conv(input_img, conv_kernel)
% input_img: type double
% conv_kernel: type double
% output_img: type double, size same as input_img
%% Write your function here

kernel_dim = size(conv_kernel);

% find the size of the padding regions for the input image
vertical_pad = (kernel_dim(1)-1)/2;
horizontal_pad = (kernel_dim(2)-1)/2;

% create the padded input image
padded_img = padarray(input_img,[vertical_pad,horizontal_pad],"circular");

% calculate the convolution
conv_result = conv2(padded_img,conv_kernel,"same");

% isolate the part of the image that is not padding
output_img = conv_result(vertical_pad+1:end-vertical_pad,horizontal_pad+1:end-horizontal_pad);

end
