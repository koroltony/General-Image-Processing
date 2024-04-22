% use random test cases to check if the fft is working well

r = randi([0 100],8,8);
im = r * 1j;
comp = rand*im + rand*r;

matlab = fft2(r);

mine = my_fft_2D(r);

disp("real number FFT");
disp(matlab-mine);

matlabi = fft2(im);

minei = my_fft_2D(im);

disp("imag number FFT");
disp(matlabi-minei);

matlabc = fft2(comp);

minec = my_fft_2D(comp);

disp("complex number FFT");
disp(matlabc-minec);