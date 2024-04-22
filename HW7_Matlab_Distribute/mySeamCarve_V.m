function [E,S] = mySeamCarve_V(EMap)
%find the vertical seam with lowest energy
%return: E: the energy of the choosen seam, S: the chosen seam
dim = size(EMap);
height = dim(1);
width = dim(2);

M = zeros(height,width);
M(1,:) = EMap(1,:);


% implement algorithm from paper
for i = 2:height
    for j = 1:width
        if (j-1)>0 && (j+1)<=width
            M(i,j) = EMap(i,j) + min([M(i-1,j-1),M(i-1,j),M(i-1,j+1)]);
        elseif (j-1) <= 0
            M(i,j) = EMap(i,j) + min([M(i-1,j),M(i-1,j+1)]);
        elseif (j+1) > width
            M(i,j) = EMap(i,j) + min([M(i-1,j-1),M(i-1,j)]);
        end
    end
end

% now we start from the minimum value in the last row of the minimum energy 
% matrix and extract the pixel locations of the seam by working backwards

S = zeros(1,height);
E = 0;

% find the minimum value at the very last row of the image
% minIndex represents the horizontal location of the pixel in the last row
[minval,minIndex] = min(M(height,:));
% S vector stores x and y in a matrix which is 2 wide and as tall as the
% image meaning that the S(1,:) represents the vertical location of the pixels 
% and S(2,:) represents the horizontal locations of the pixels in the seam
S(height) = minIndex;
E = E+minval;

% iterate through all rows backwards to find coordinates
for i = height-1:-1:1
    % use previous horizontal position to choose next minimum seam value
    prevIndex = S(i+1);
    if (prevIndex-1)>0 && (prevIndex+1)<=width
        % outputs 1 if left index is smallest, 2 if middle index is
        % smallest, and 3 if right index is smallest.
        [minval,minIndex] = min([M(i,prevIndex-1),M(i,prevIndex),M(i,prevIndex+1)]);
        % map minIndex to shifted index
        minIndex = minIndex + prevIndex - 2;
    elseif (prevIndex-1) <= 0
        [minval,minIndex] = min([M(i,prevIndex),M(i,prevIndex+1)]);
        minIndex = minIndex + prevIndex - 1;
    elseif (prevIndex+1) > width
        [minval,minIndex] = min([M(i,prevIndex-1),M(i,prevIndex)]);
        % gives 1 for left and 2 for same x coordinate
        minIndex = prevIndex - 2 + minIndex;
    end
    S(i) = minIndex;
    E = E+minval;
end

