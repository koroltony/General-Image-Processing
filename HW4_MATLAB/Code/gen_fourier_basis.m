function [B] = gen_fourier_basis(input_img,p,q)
% This function generates the (p,q)th basis for image I
dim  = size(input_img);

M = dim(1);
N = dim(2);

B = zeros(M,N);
for m = 1:M
    for n = 1:N
        % you must weigh the basis by the input image in order to get
        % non-zero output image in the video
        B(m,n) = uint8(double(input_img(m,n))*exp(1j*2*pi*((p*(m-1)/M+q*(n-1)/N))));
    end
end

end