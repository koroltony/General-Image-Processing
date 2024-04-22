function E = myEnergyFunc(Img,grad,seam,direction)

% Implemented using gradients. Implemented a smaller window for
% recalculation of seams in the image

% -------------------------------------------------------------------------

% make image into a grayscale in order to extract a single gradient
    ImgGray = rgb2gray(Img);

    dim = size(ImgGray);
    height = dim(1);
    width = dim(2);

% if a seam was removed calculate a local energy map. For the vertical seam
% case, I am using a window of -5 to 5 around the area of the seam
if strcmp(direction,'v') == 1 && min(seam) - 3 > 1 && max(seam) + 3 < width
    % only calculate the energy within a 5 pixel radius of the seam
    minx = min(seam) - 3;
    maxx = max(seam) + 3;

    % keep image gradient the same as 'grad' which is the previous
    % gradient, except in between these min and max values

    % set the E to the previous gradient
    E = grad;
    [Enewxx, Enewyx] = imgradientxy(ImgGray(:, minx:maxx));
    E(:, minx:maxx) = abs(Enewxx)+abs(Enewyx);
    
% for the horizontal case, I am using a +- 5 area around the seam as well
elseif strcmp(direction,'h') == 1 && min(seam) - 3 > 1 && max(seam) + 3 < height
    % only calculate the energy within a 5 pixel radius of the seam
    miny = min(seam) - 3;
    maxy = max(seam) + 3;

    % keep image gradient the same as 'grad' which is the previous
    % gradient, except in between these min and max values

    % set the E to the previous gradient
    E = grad;
    [Enewxy, Enewyy] = imgradientxy(ImgGray(miny:maxy,:));
    E(miny:maxy,:) = abs(Enewxy)+abs(Enewyy);
else
    % if there is no seam or if it is at a boundary case, do full gradient
    % calculate image gradint in x and y
    [gradx, grady] = imgradientxy(ImgGray);

    % calculate magnitude of energy per pixel by first doing element-wise squaring and
    % then square rooting, and finally, scaling down to emphasize larger edges
    E = abs(gradx)+abs(grady);
end
