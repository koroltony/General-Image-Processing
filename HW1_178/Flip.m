
% Implements vertical flip of image
function flipout = Flip(input)

    % extract dimensions of image
    dimensions = size(input);

    % get width and height
    height = dimensions(1);
    width = dimensions(2);

    % create a new output image
    newIm = zeros(height,width,4);

    % vertically flip by making i "backwards" indexed
    for i = 1:height
        for j = 1:width
            for k = 1:4
                newIm(i,j,k) = input(height-i+1,j,k);
            end
        end
    end

    % create output image
    
    flipout = newIm;
    
end

