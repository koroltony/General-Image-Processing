function scaled_img = CDFmethod(input_img)

dimensions = size(input_img);
height = dimensions(1);
width = dimensions(2);

% there are 256 intensity levels in the grayscale image
L = 256;

% create histogram of all values in image
hist = zeros(1,L);

% fill histogram with intensity frequencies (indexing starts at 1)
for i = 1:height
    for j = 1:width
        hist(input_img(i,j)+1) = hist(input_img(i,j)+1) + 1;
    end
end

% normalize the histogram probabilities by dividing by total pixel count
normHist = hist/(height*width);

% create cumulative probability vector 
cumulative = zeros(size(normHist));
% first value in cumulative probability is the same as the normalized value
cumulative(1) = normHist(1);

% create cumulative probability by adding normalized probabilities and
% previous cumulative sum
for i = 2:L
    cumulative(i) = cumulative(i-1)+normHist(i);
end

% scale the cumulative probability to the number of bins in the image
Equalized = cumulative * (L-1);

% round to integer values for representation in image
rounded = round(Equalized);

% create vector for scaled image (uint8 to represent 0 to 255 values
scaled_img = uint8(zeros(size(input_img)));

% use rounded vector as look up table to fill the scaled image
for i = 1:height
    for j = 1:width
        scaled_img(i,j) = rounded(input_img(i,j)+1);
    end
end

