% saturates color of image
function satout = saturate(input)

    % extract dimensions of image
    dimensions = size(input);

    % get width and height
    height = dimensions(1);
    width = dimensions(2);

    % create a new output image
    newIm = zeros(height,width,4);

    % saturate the image

    newIm(:,:,1:3) = input(:,:,1:3).*(1.5);

    newIm(:,:,4) = input(:,:,4);

    % create output image
    
    satout = newIm;
    
end