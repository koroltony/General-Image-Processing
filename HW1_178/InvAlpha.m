% Implements alpha channel inversion of image
function invalphaout = InvAlpha(input)

    % extract dimensions of image
    dimensions = size(input);

    % get width and height
    height = dimensions(1);
    width = dimensions(2);

    % create a new output image
    newAlpha = zeros(height,width,4);

    newAlpha(:,:,1:3) = input(:,:,1:3);
    
    % invert by subracting current value from 1
    newAlpha(:,:,4) = 1-input(:,:,4);
    % create output image
    
    invalphaout = newAlpha;
    
end