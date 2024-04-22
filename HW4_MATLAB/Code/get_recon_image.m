function [R] = get_recon_image(M,N,F,B,p,q)
% This function weighs the basis with its corresponding fourier
% coefficient.

% scale the output reconstructed image by the total number of pixels and
% elementwise multiply with the corresponding basis
R = (1/(M*N))*F.*B(p+1,q+1);
end