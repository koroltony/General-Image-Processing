function output_img = myConv2(input_image, myfilter, padding_method)
% input_image    : noisy input image (type: double)
% myfilter       : filter kernel to be used for convolution (type: double)
% padding_method : string that specifies the type of padding method to be used
% output_img     : output image (type: double)

%% implement your 2D convolution here


%% First, perform appropriate padding on the input_image to get padded_input_image

% create variables for filter size
Fdim = size(myfilter);
Fheight = Fdim(1);
Fwidth = Fdim(2);
% distance around the center pixel to which the filter extends
% also represents the width of the padding around the image
freachw = (Fwidth-1)/2;
freachh = (Fheight-1)/2;

% dimensions of input image
Imgdim = size(input_image);
imgheight = Imgdim(1);
imgwidth = Imgdim(2);

% create padded image vector and dimensions
padded_input_image = zeros(freachh*2+imgheight,freachw*2+imgwidth);
pdim = size(padded_input_image);
pheight = pdim(1);
pwidth = pdim(2);

if strcmp(padding_method,'repeating')
    % your code to implement padding using 'repeating' method
    for i = 1:pheight
        for j = 1:pwidth
            % implement padding along left side of image
            if(j<=freachw && i>freachh && i<=freachh+imgheight)
                padded_input_image(i,j) = input_image(i-freachh,imgwidth-freachw+j);
            % implement padding on right side of image
            elseif(j>freachw+imgwidth && i>freachh && i<=freachh+imgheight)
                padded_input_image(i,j) = input_image(i-freachh,j-imgwidth-freachw);
            % top side of padding region (0 for now)
            elseif(i<=freachh)
                padded_input_image(i,j) = 0;
            % bottom side of padding region (0 for now)
            elseif(i>freachh+imgheight)
                padded_input_image(i,j) = 0;
            % fill the middle part of the padded image with the original
            else
                padded_input_image(i,j) = input_image(i-freachh,j-freachw);
            end
        end
    end
    % populate the top and bottom edge of the padded image by repeating 
    % the rest of the padded image which was filled before
    for i = 1:pheight
        for j = 1:pwidth
            % top side of padding region
            if(i<=freachh)
                padded_input_image(i,j) = padded_input_image(imgheight+i,j);
            % bottom side of padding region
            elseif(i>freachh+imgheight)
                padded_input_image(i,j) = padded_input_image(i-imgheight,j);
            end
        end
    end
elseif strcmp(padding_method,'mirroring')
    % your code to implement padding using 'mirroring' method
    for i = 1:pheight
        for j = 1:pwidth
            % left side of padding region
            if(j<=freachw && i>freachh && i<=freachh+imgheight)
                padded_input_image(i,j) = input_image(i-freachh,freachw+1-j);
            % right side of padding region
            elseif(j>freachw+imgwidth && i>freachh && i<=freachh+imgheight)
                padded_input_image(i,j) = input_image(i-freachh,2*imgwidth-j+freachh);
            % top side of padding region (0 for now)
            elseif(i<=freachh)
                padded_input_image(i,j) = 0;
            % bottom side of padding region (0 for now)
            elseif(i>freachh+imgheight)
                padded_input_image(i,j) = 0;
            else
                padded_input_image(i,j) = input_image(i-freachh,j-freachw);
            end
        end
    end
    for i = 1:pheight
        for j = 1:pwidth
            % top side of padding region
            if(i<=freachh)
                padded_input_image(i,j) = padded_input_image((Fheight-1)+2-i,j);
            % bottom side of padding region
            elseif(i>freachh+imgheight)
                padded_input_image(i,j) = padded_input_image(2*(freachh+imgheight)-i,j);
            end
        end
    end
else 
    % default zero-padding
    for i = 1:pheight
        for j = 1:pwidth
            if(j<=freachw || i<=freachh || j>freachw+imgwidth || i>freachh+imgheight)
                padded_input_image(i,j) = 0;
            else
                padded_input_image(i,j) = input_image(i-freachh,j-freachw);
            end
        end
    end
end

%% perform convolution operation using the padded_input_image and myfilter to get the output_img

output_img = zeros(imgheight,imgwidth);
% perform convolution across entire padded image
for i = 1:pheight
    for j = 1:pwidth
        % only consider pixels from the original image (not the padding)
        if(j>freachw && i>freachh && j<=freachw+imgwidth && i<=freachh+imgheight)
            % isolate the part of the padded image you are convolving with
            conv_section = padded_input_image(i-freachh:i+freachh,j-freachw:j+freachw);
            % perform weighted sum for convolution
            output_img(i-freachh,j-freachw) = sum(myfilter.*conv_section,"all");
        end
    end
end