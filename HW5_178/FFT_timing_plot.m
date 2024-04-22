% run from 2 to 2^7 size matrices
n = 7;

% Generating sizes as powers of 2
test_sizes = 2 .^ (1:n);

% store the matrices in a cell array with 7 spots
test_vector = cell(1, n);

for i = 1:n
    test_vector{i} = ones(test_sizes(i));
end

myTime = zeros(1, n);
dftTime = zeros(1, n);

% calculate the time taken for each method for each size
for i = 1:n
    % time for fft
    tic
    my_fft_2D(test_vector{i});
    myTime(i) = toc;

    % time for dft
    tic
    my_dft_2D(test_vector{i});
    dftTime(i) = toc;
end

% plot the graphs
figure;

% fft plot
subplot(2, 1, 1);
plot(test_sizes, myTime, 'DisplayName', 'FFT Time');
title('FFT Time');
xlabel('Image Size (N)');
ylabel('Time (seconds)');

% dft plot
subplot(2, 1, 2);
plot(test_sizes, dftTime, 'DisplayName', 'DFT Time');
title('DFT Time');
xlabel('Image Size (N)');
ylabel('Time (seconds)');
