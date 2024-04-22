% Implements color inversion of image
function invout = Inv(input)

    % extract dimensions of image
    dimensions = size(input);

    % get width and height
    height = dimensions(1);
    width = dimensions(2);

    % create a new output image
    newIm = zeros(height,width,4);
    newIm(:,:,4) = input(:,:,4);

    % invert by subracting current value from 1
    for i = 1:height
        for j = 1:width
            for k = 1:3
                newIm(i,j,k) = 1-input(i,j,k);
            end
        end
    end

    % create output image
    
    invout = newIm;
    
end

