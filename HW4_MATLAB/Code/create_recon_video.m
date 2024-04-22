function [] = create_recon_video(Recon)
% Your video should display top 100 fourier basis and their corresponding
% reconstructed images. After that display every 10th reconstructed image
% and its basis. Effectively you will get[num = 100+(M*N-100)/10] reconstructed 
% images in the image sequence to be converted to video.
% For creating the video - horizontally concatenate corresponding
% reconstructed images and fourier basis and follow the directions in 
% http://www.mathworks.com/help/matlab/examples/convert-between-image-sequences-and-video.html#zmw57dd0e6614
% Your function should save the video as 'Image_Recon.mov/avi'.
    
video = VideoWriter('Image_Recon');
open(video);
dim = size(Recon.basis{1});

M = dim(1);
N = dim(2);
% created a new vector to store the image because the given code was not
% working out well with my inputs. I just did the summation of images
% myself in the loops which ended up giving decent results.
image = zeros(M,N);

for i = 1:100
    basis = abs(Recon.basis{i});
    % here, I implemented the gradual summation of the image from the basis
    % we calculated earlier (not relying on the recon code because it was
    % not producing the desired output
    image = image + double(basis)/255;
 
    combined = horzcat(basis,image);
            
    writeVideo(video,uint8(combined));
end

for j = 100:10:10000
    basis = abs(Recon.basis{j});
    image = image + double(basis)/255;
 
    combined = horzcat(basis,image);
            
    writeVideo(video,uint8(combined));
end

close(video);
    
end