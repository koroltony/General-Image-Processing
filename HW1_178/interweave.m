% Weave together two images of the same dimension
function intout = interweave(a,b)

    % extract dimensions of image
    dimensions = size(a);

    % get width and height
    height = dimensions(1);

    % create a new output image
    newIm = a;

    % replace certain rows of image a with image b

    for j = (1:12:height)
        newIm(j,:,:) = b(j,:,:);
        newIm(j+1,:,:) = b(j+1,:,:);
        newIm(j+2,:,:) = b(j+2,:,:);
    end

    % create output image
    
    intout = newIm;
    
end
