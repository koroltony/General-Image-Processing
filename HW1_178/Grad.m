% calculates gradient of image a with central difference
function gradout = Grad(a)

    dimensions = size(a);
    height = dimensions(1);
    width = dimensions(2);

    gradient = zeros(2,height,width,3);

    % calculate x value of gradient for RGB
    
    for i = 1:height
        % when not at the edge of the image
        if i ~= 1 && i ~= height
            % set the y component rgb to the central diff of vertical ax
            gradient(2,i,:,:) = (a(i+1,:,1:3)-a(i-1,:,1:3))/2;
        % I will set the gradient to 0 at the edges of the image because
        % central difference is undefined here
        else
            gradient(2,i,:,:) = 0;
        end
    end

    for j = 1:width
        % when not at the edge of the image
        if j ~= 1 && j ~= width
            % set the x component rgb to the central diff of horizontal ax
            gradient(1,:,j,:) = (a(:,j+1,1:3)-a(:,j-1,1:3))/2;
        % I will set the gradient to 0 at the edges of the image because
        % central difference is undefined here
        else
            gradient(1,:,j,:) = 0;
        end
    end

    gradout = gradient;
end

