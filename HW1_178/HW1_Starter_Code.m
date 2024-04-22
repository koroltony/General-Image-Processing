% Read image file.
% "fg": uint8 RGB channels
% "fg_alpha": uint8 Alpha channel
[lemur,~,lemur_alpha]=imread("1_Lemur.png");

% extra images for testing A atop B function----------
[source,~,source_alpha]=imread("source.png");
[dest,~,dest_alpha]=imread("dest.png");
[trolls,~,trolls_alpha]=imread("2_Trolls.png");
%-----------------------------------------------------

% Append the alpha channel as an extra channel.
% TODO(students): Must check if there even is an alpha channel first.
if ~isempty(lemur_alpha) 
    lemur(:,:,4) = lemur_alpha;
else
    % set alpha channel to 1 if there is no alpha channel
    lemur(:,:,4) = 1;
end

if ~isempty(source_alpha) 
    source(:,:,4) = source_alpha;
else
    source(:,:,4) = 1;
end

if ~isempty(dest_alpha) 
    dest(:,:,4) = dest_alpha;
else
    dest(:,:,4) = 1;
end

if ~isempty(trolls_alpha) 
    trolls(:,:,4) = trolls_alpha;
else
    trolls(:,:,4) = 1;
end

% ---------------------------------------------------

% Convert from uint8 [0,255] to double precision floating point [0,1].
lemur=im2double(lemur);
source=im2double(source);
dest=im2double(dest);
trolls=im2double(trolls);

% Pre-multiply alpha channel on true color components.
lemur(:,:,1:3)=lemur(:,:,1:3).*lemur(:,:,4);
source(:,:,1:3)=source(:,:,1:3).*source(:,:,4);
dest(:,:,1:3)=dest(:,:,1:3).*dest(:,:,4);
trolls(:,:,1:3)=trolls(:,:,1:3).*trolls(:,:,4);

% Read the background image.
% There is no alpha channel for JPGs, set to 1.
% No need to pre-multiply (since all 1's).
background=im2double(imread("1_Background.jpg"));
background(:,:,4)=1;
background2=im2double(imread("2_Background.jpg"));
background2(:,:,4)=1;
twinkle=im2double(imread("IMG_2928.jpg"));
twinkle(:,:,4)=1;

% Call your function on the pre-multiplied, combined RGB+Alpha images.
%Save the returned, output image.
lemurflip = Flip(lemur);
lemurflop = Flop(lemur);
bgflip = Flip(background);
bgflop = Flop(background);
invbg = Inv(background);
invfg = Inv(lemur);
invalpha = InvAlpha(lemur);

% test invalpha on non-premultiplied image-----

[Origlemur,~,Origlemur_alpha]=imread("1_Lemur.png");
Origlemur(:,:,4) = Origlemur_alpha;
Origlemur = im2double(Origlemur);
org2 = Origlemur(:,:,1:3);
oinvalpha = InvAlpha(Origlemur);

%----------------------------------------------

imwrite(lemurflip(:,:,1:3),"fgflipped.jpg");
imwrite(lemurflop(:,:,1:3),"fgflopped.jpg");
imwrite(bgflip(:,:,1:3),"bgflipped.jpg");
imwrite(bgflop(:,:,1:3),"bgflopped.jpg");
imwrite(invbg(:,:,1:3),"bginv.jpg");
imwrite(invfg(:,:,1:3),"fginv.jpg");
imwrite(invalpha(:,:,1:3),"fgalphainv.png",'Alpha',invalpha(:,:,4));
imwrite(oinvalpha(:,:,1:3),"ogalphainv.png",'Alpha',oinvalpha(:,:,4));


% TODO(students): Implement `Over`, `Atop`, `Xor`, etc...
% test case 1
out=Atop(Flip(dest),Flop(source));
% test case 2
out1=Atop(Flop(source),Flop(dest));
% test case 3
out2=Xor(source,dest);
% test case 3
out3=Xor(dest,source);
% test case 4
out4=Over(lemur,background);
% test case 5
out5=Over(Flop(trolls),background2);

% creating custom image--------------
out6=saturate(gradual(lemur));
out7=interweave(gradual(background),background);
out8=Over(Flop(out6),out7);
%------------------------------------

% testing grad function
tempgrad=Grad(lemur);
out9=squeeze(tempgrad(1,:,:,:));
out10=squeeze(tempgrad(2,:,:,:));
out11=out9+out10;

tempgrad1=Grad(twinkle);
out12=squeeze(tempgrad1(1,:,:,:));
out13=squeeze(tempgrad1(2,:,:,:));
out14=out12+out13;

out15=(interweave(gradual(twinkle),twinkle));

% Display the output image; write it to a JPEG file (no alpha channel).
% Only first 3 channels (RGB) since they will already be pre-multiplied.
% (See Porter & Duff for details)
imwrite(out(:,:,1:3),"out.jpg");
imwrite(out1(:,:,1:3),"out1.jpg");
imwrite(out2(:,:,1:3),"out2.jpg");
imwrite(out3(:,:,1:3),"out3.jpg");
imwrite(out4(:,:,1:3),"out4.jpg");
imwrite(out5(:,:,1:3),"out5.jpg");
imwrite(out6(:,:,1:3),"out6.jpg");
imwrite(out7(:,:,1:3),"out7.jpg");
imwrite(out8(:,:,1:3),"out8.jpg");
imwrite(out9(:,:,1:3),"out9.jpg");
imwrite(out10(:,:,1:3),"out10.jpg");
imwrite(out11(:,:,1:3),"out11.jpg");
imwrite(out12(:,:,1:3),"out12.jpg");
imwrite(out13(:,:,1:3),"out13.jpg");
imwrite(out14(:,:,1:3),"out14.jpg");
imwrite(out15(:,:,1:3),"out15.jpg");


% Or, just write to a PNG file (with alpha channel).
% Must recover true colors from pre-multiplied alpha.
% TODO(students): Think about the edge cases in the division op here.
imwrite(revert(out),"out.png",'Alpha',out(:,:,4));
imwrite(revert(out1),"out1.png",'Alpha',out1(:,:,4));
imwrite(revert(out2),"out2.png",'Alpha',out2(:,:,4));
imwrite(revert(out3),"out3.png",'Alpha',out3(:,:,4));
imwrite(revert(out4),"out4.png",'Alpha',out4(:,:,4));
imwrite(revert(out5),"out5.png",'Alpha',out5(:,:,4));
imwrite(revert(out6),"out6.png",'Alpha',out6(:,:,4));
imwrite(revert(out7),"out7.png",'Alpha',out7(:,:,4));
imwrite(revert(out8),"out8.png",'Alpha',out8(:,:,4));

% implementing over function
function out=Over(a,b)
    dimensions = size(a);

    height = dimensions(1);
    width = dimensions(2);

    % fourth channel stores alpha value
    newIm = zeros(height,width,4);

    % stores the F value for img a and b
    Fa = ones(height,width);
    Fb = zeros(height,width);

    % calculate b factor for all pixels
    for i = 1:height
        for j = 1:width
            Fb(i,j) = 1-a(i,j,4);
        end
    end

    % set RGB values to premultiplied RGB*factor
    newIm(:,:,1:3) = a(:,:,1:3).*Fa + b(:,:,1:3).*Fb;
    % set the alpha for the new image
    newIm(:,:,4) = a(:,:,4).*Fa + b(:,:,4).*Fb;

    out = newIm;
end

function out=Atop(a,b)
    dimensions = size(a);

    height = dimensions(1);
    width = dimensions(2);

    newIm = zeros(height,width,4);

    Fa = zeros(height,width);
    Fb = zeros(height,width);

    for i = 1:height
        for j = 1:width
            % find Fa and Fb for Atop
            Fa(i,j) = b(i,j,4);
            Fb(i,j) = 1-a(i,j,4);
        end
    end

    % calculate RGB of combined image and alpha channel of new image
    newIm(:,:,1:3) = a(:,:,1:3).*Fa + b(:,:,1:3).*Fb;
    newIm(:,:,4) = a(:,:,4).*b(:,:,4) + b(:,:,4) .* (1 - a(:,:,4));

    out = newIm;
end

function out=Xor(a,b)
    dimensions = size(a);

    height = dimensions(1);
    width = dimensions(2);

    newIm = zeros(height,width,4);

    Fa = zeros(height,width);
    Fb = zeros(height,width);

    for i = 1:height
        for j = 1:width
            % calculate Fa and Fb for Xor
            Fa(i,j) = 1-b(i,j,4);
            Fb(i,j) = 1-a(i,j,4);
        end
    end

    % calculate RGB of combined image and alpha channel of new image
    newIm(:,:,1:3) = a(:,:,1:3).*Fa + b(:,:,1:3).*Fb;
    newIm(:,:,4) = a(:,:,4).*Fa + b(:,:,4) .*Fb;

    out = newIm;
end

% implement conversion from premultiplied RGB to original RGB for use in
% png file format
function RGBout = revert(input)
    dimensions = size(input);
    height = dimensions(1);
    width = dimensions(2);

    newIm = zeros(height,width,3);

    for i = 1:height
        for j = 1:width
            % check that we are not dividing by 0
            if input(i,j,4) ~= 0
                newIm(i,j,1:3) = input(i,j,1:3)./input(i,j,4);
            else
                newIm(i,j,1:3) = 0;
            end
        end
    end
    RGBout = newIm;
end
