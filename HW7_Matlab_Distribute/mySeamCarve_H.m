function [E, S] = mySeamCarve_H(EMap)
    % find the horizontal seam with lowest energy
    % return: E: the energy of the chosen seam, S: the chosen seam
    dim = size(EMap);
    height = dim(1);
    width = dim(2);

    M = zeros(height, width);
    M(:, 1) = EMap(:, 1);

    for j = 2:width
        for i = 1:height
            if (i-1) > 0 && (i+1) <= height
                M(i, j) = EMap(i, j) + min([M(i-1, j-1), M(i, j-1), M(i+1, j-1)]);
            elseif (i-1) <= 0
                M(i, j) = EMap(i, j) + min([M(i, j-1), M(i+1, j-1)]);
            elseif (i+1) > height
                M(i, j) = EMap(i, j) + min([M(i-1, j-1), M(i, j-1)]);
            end
        end
    end

    % now we start from the minimum value in the last column of the minimum energy
    % matrix and extract the pixel locations of the seam by working backwards

    S = zeros(1, width);
    E = 0;

    % find the minimum value at the very last column of the image
    % minIndex represents the vertical location of the pixel in the last column
    [minval, minIndex] = min(M(:, width));

    % S vector stores x and y in a matrix, where S(1, :) represents the vertical
    % location of the pixels and S(2, :) represents the horizontal locations of the pixels in the seam
    S(width) = minIndex;
    E = E + minval;

    % iterate through all columns backwards to find coordinates
    for j = width-1:-1:1
        % use previous vertical position to choose the next minimum seam value
        prevIndex = S(j+1);
        if (prevIndex-1) > 0 && (prevIndex+1) <= height
            % again, only gives which one is larger, 1,2 or 3 which needs
            % to be mapped to a new position
            [minval, minIndex] = min([M(prevIndex-1, j), M(prevIndex, j), M(prevIndex+1, j)]);
            % map minIndex to shifted index
            minIndex = minIndex + prevIndex - 2;
        elseif (prevIndex-1) <= 0
            [minval, minIndex] = min([M(prevIndex, j), M(prevIndex+1, j)]);
            minIndex = minIndex + prevIndex - 1;
        elseif (prevIndex+1) > height
            [minval, minIndex] = min([M(prevIndex-1, j), M(prevIndex, j)]);
            % gives 1 for left and 2 for same x coordinate
            minIndex = prevIndex - 2 + minIndex;
        end
        % map above values to pixel shifts
        S(j) = minIndex;
        E = E + minval;
    end
end

