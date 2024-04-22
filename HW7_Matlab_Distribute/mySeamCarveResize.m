function rImg = mySeamCarveResize(Img,rC,rR)
%rC: number of columns to be removed
%rR: number of row to be removed

% filter image to make seams more accurate:

Img = imbilatfilt(Img);

% iterate through seam deletions until desired count is reached
i = 0;

while i<rC
    % find initial energy map of image
    if i == 0
        Energy = myEnergyFunc(Img,0,0,0);
    % if another seam has been computed, use the old energy map for
    % optimization
    else
        Energy = oldeng;
    end
    % extract image and energy map for next iteration
    [Img,oldeng] = removeVseam(Img,Energy);
    i = i+1;
end

% same thing but for horizontal seams
j = 0;

while j<rR
    % find energy map of image
    if j == 0
        Energy = myEnergyFunc(Img,0,0,0);
    else
        Energy = oldeng;
    end
    [Img,oldeng] = removeHseam(Img,Energy);
    j = j+1;
end

rImg = Img;

    % seam removal in the vertical case, which also carries out the
    % calculation of the new energy for the next iteration in a localized
    % window around the seam
    function [OneRemovedV,newEng] = removeVseam(Img, EMap)
    % Resize the image to be one pixel less wide and remove the seam
    [~, Seam] = mySeamCarve_V(EMap);
    dim = size(Img);
    height = dim(1);
    width = dim(2) - 1;

    % outEng is the new energy vector
    OneRemovedV = zeros(height, width, 3);
    outEng = zeros(height,width);

    for k = 1:height
        % find the "x" value to remove in this row
        colToRemove = Seam(k);
        % cut that value out of the image
        OneRemovedV(k, :, :) = Img(k, [1:colToRemove-1, colToRemove+1:end], :);
        % outEng is shrunk by removing the seam pixels
        outEng(k, :) = EMap(k, [1:colToRemove-1, colToRemove+1:end]);
    end
    % the energy map is recomputed locally for the new energy output
    newEng = myEnergyFunc(OneRemovedV,outEng,Seam,'v');
end

    function [OneRemovedH,newEng] = removeHseam(Img, EMap)
    % Resize the image to be one pixel less tall and remove the seam
    [~, Seam] = mySeamCarve_H(EMap);
    height = size(Img, 1) - 1;
    width = size(Img, 2);

    OneRemovedH = zeros(height, width, 3);
    outEng = zeros(height,width);

    for k = 1:width
        rowToRemove = Seam(k);
        OneRemovedH(:, k, :) = Img([1:rowToRemove-1, rowToRemove+1:end], k, :);
        outEng(:, k) = EMap([1:rowToRemove-1, rowToRemove+1:end], k);
    end
    newEng = myEnergyFunc(OneRemovedH,outEng,Seam,'h');
end
end
