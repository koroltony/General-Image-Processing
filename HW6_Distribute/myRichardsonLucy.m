function outImg = myRichardsonLucy(Img,PSF,iter)

    % I chose to use myConv2 instead of conv2 because it allows me to use
    % mirrored padding easily which makes edge artifacts less visible
    
    % cast everything to double for myConv2
    PSF = double(PSF);
    Img = double(Img);
    % make the flipped kernel by rotating 180 degrees
    PSF_Flipped = rot90(PSF,2);
    
    % set the original estimate to be the blurred input
    u = Img;

    for i = 1:iter
        % for each iteration, convolve the blur kernel with the estimate
        uconvp = myConv2(u,PSF,'mirroring');
        % divide the original blurred image by this blurred estimate
        comparison = Img./uconvp;
        % convolve this ratio with the flipped blur kernel
        comparisonconv = myConv2(comparison,PSF_Flipped,'mirroring');
        % scale the next iteration's estimate by the convolved comparison
        u = u.*comparisonconv;
    end
    % after all iterations you have the deconvolved image
    outImg = u;
end

