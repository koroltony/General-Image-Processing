function plotMyHistogram(input_img, num_bins) 

dimensions = size(input_img);

height = dimensions(1);
width = dimensions(2);

% split 256 into even intervals based on # of bins
interval = round(256/num_bins);
bins = 0:interval:255;

% set up vector to store histogram values
histval = zeros(size(bins));

% iterate through image and iterate histogram numbers any time a pixel is
% within the range of a bin
for i = 1:height
    for j = 1:width
        for k = 1:(length(bins)-1)
            if(input_img(i,j)<bins(k+1)&&input_img(i,j)>=bins(k))
                histval(k) = histval(k) + 1;
            end
        end
    end
end

% plot histogram
figure;
bar(bins,histval,'hist');
title('Image Histogram');
xlabel('Greyscale Intensity (0-255)');
ylabel('Number of Instances');

end

