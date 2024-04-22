function filter = myGaussianFilter(height,width,mu,sigma)
% height   : height of the filter kernel matrix
% width    : width of the filter kernel matrix
% mu       : mean 
% sigma    : standard deviation
% filter   : output filter kernel matrix of type double

%% implement your Gaussian filter here

filter = zeros(height,width);

% since the kernel index starts at 1,1 but the center of the kernel
% is at the middle, we need to offset the indexing by the center distance
center = (height-1)/2+1;

for i = 1:height
    for j = 1:width
        filter(i,j) = exp((-((i-center)^2+(j-center)^2))/(2*(sigma)^2));
    end
end

% normalize so the values sum to 1:

filter = filter/sum(filter,"all");