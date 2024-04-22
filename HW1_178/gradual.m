% Implements gradual horizontal color scaling
function gout = gradual(input)

    % extract dimensions of image
    dimensions = size(input);

    % get width and height
    height = dimensions(1);
    width = dimensions(2);

    % create a new output image
    newIm = zeros(height,width,4);

    for j = 1:width
        % Gradually filter out green horizontally
        newIm(:,j,2) = input(:,j,2).*(j/width);
        % Gradually filter out blue horizontally
        newIm(:,j,3) = input(:,j,2).*((width-j+1)/width);
        % Make everything more red
        newIm(:,j,1) = input(:,j,1).*1.3;
    end

    newIm(:,:,4) = input(:,:,4);

    % create output image
    
    gout = newIm;
    
end
