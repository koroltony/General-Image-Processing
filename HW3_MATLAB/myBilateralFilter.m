function outImage = myBilateralFilter(A,w,sigma_s,sigma_r)
% A        : noisy input image (type: double)
% w        : window size for bilateral filter
% sigma_s  : spatial standard deviation for bilateral filter
% sigma_r  : range standar deviation for bilateral filter
% outImage : bilateral filtered output image (type: double)

%% implement bilateral filter here

% create size variables
dim = size(A);

height = dim(1);
width = dim(2);

filterw = 2*w + 1;
filterh = 2*w + 1;

% pad input image with zero padding
padded_input_image = zeros(height+2*w,width+2*w);

pdim = size(padded_input_image);

pheight = pdim(1);
pwidth = pdim(2);

for i = 1:pheight
    for j = 1:pwidth
        if(j<=w || i<=w || j>w+width || i>w+height)
            padded_input_image(i,j) = 0;
        else
            padded_input_image(i,j) = A(i-w,j-w);
        end
    end
end

% set up gaussian filter kernel in 2d

filter = zeros(filterh,filterw);

% since the kernel index starts at 1,1 but the center of the kernel
% is at the middle, we need to offset the indexing by the center distance
center = w+1;

for i = 1:filterh
    for j = 1:filterw
        filter(i,j) = exp((-((i-center)^2+(j-center)^2))/(2*(sigma_s)^2));
    end
end

% 1d gaussian filter combined with 2d gaussian
outImage = A;
d1filter = zeros(filterh,filterw);
for i = 1:pheight
    for j = 1:pwidth
        % for pixels contained in the original image (not padding)
        if(j>w && i>w && j<=w+width && i<=w+height)
            % iterate through 1d gaussian indices to create a new 1d
            % gaussian kernel for each pixel of the input image
            for k = 1:filterh
                for l = 1:filterw
                    d1filter(k,l) = exp((-(padded_input_image(i,j)-padded_input_image(i-w+k-1,j-w+l-1))^2)/(2*(sigma_r)^2));
                end
            end
            % find normalization constant and apply filter to each pixel in
            % the input image
            padded_subset = padded_input_image(i-w:i+w,j-w:j+w);
            normalization = sum(filter.*d1filter,"all");
            outImage(i-w,j-w) = 1/normalization*sum(filter.*padded_subset.*d1filter,"all");
        end
    end
end
