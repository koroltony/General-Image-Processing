% Implements horizontal flop of image
function flopout = Flop(input)

    % extract dimensions of image
    dimensions = size(input);

    % get width and height
    height = dimensions(1);
    width = dimensions(2);

    % create a new output image
    newIm = zeros(height,width,4);

    % horizontally flip by making j "backwards" indexed
    for i = 1:height
        for j = 1:width
            for k = 1:4
                newIm(i,j,k) = input(i,width-j+1,k);
            end
        end
    end

    % create output image
    
    flopout = newIm;
    
end
