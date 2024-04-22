function downsampled_img = myDownSampling(input_img, downsampling_rate, method)
    
    % for gaussian antialiasing we first make the gaussian kernel using
    % myGaussianFilter.m and then use myConv2 to convolve it with the image
    if strcmp(method,'Gaussian')
        Gkernel = myGaussianFilter(17,17,0,5);
        anti_alias = myConv2(input_img,Gkernel,'mirroring');
    % same process as the gaussian filter but for a simple box filter
    elseif strcmp(method, 'Box filter')
        Bkernel = (1/17)^2*ones(17,17);
        anti_alias = myConv2(input_img,Bkernel,'mirroring');
    % in the no filter case we use the input image as the input for
    % downsampling
    else
        anti_alias = input_img;
    end

    % find dimensions of the input image
    oldDim = size(input_img);
    
    % create dimensions for the intermediate step of downsampling rows
    NewHeight = floor((oldDim(1)-1)/(downsampling_rate));
    % create width dimension for final downsampled image
    NewWidth = floor((oldDim(2)-1)/(downsampling_rate));
    % create intermediate image for downsampling rows
    downsampled_img_1 = zeros(NewHeight,oldDim(2));
    % create final downsampled image
    downsampled_img = zeros(NewHeight,NewWidth);

    % downsample rows and store in intermediate image
    for i = 1:NewHeight
        downsampled_img_1(i,:) = anti_alias(downsampling_rate*(i-1)+1,:);
    end

    % use row-downsampled intermediate image to find final downsampled
    % image by downsampling its columns
    for i = 1:NewWidth
        downsampled_img(:,i) = downsampled_img_1(:,downsampling_rate*(i-1)+1);
    end
