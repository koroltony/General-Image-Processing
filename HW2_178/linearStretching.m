function scaled_img = linearStretching(input_img, start_intensity, end_intensity)

% We want the histogram to be scaled with y = AI - B

% find the spread of the intensity values
range = end_intensity - start_intensity;
% find multiplicative scaling factor
A = round(255/range);

% create linearly scaled image
scaled_img = (input_img-start_intensity)*A;

