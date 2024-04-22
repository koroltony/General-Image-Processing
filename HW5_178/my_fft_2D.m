function [fft] = my_fft_2D(img)

dim = size(img);
height = dim(1);
width = dim(2);

fft_int = zeros(height,width);
fft = zeros(height,width);

% call fft helper on columns

for i = 1:width
    fft_int(:,i) = ffth(img(:,i)).';
end

% call fft helper on previous columnwise fft

for i = 1:height
    fft(i,:) = ffth(fft_int(i,:));
end

end

% implement recursive 1D FFT
function [fft1] = ffth(signal)
    
    N = length(signal);
    fft1 = zeros(1,N);

    % create condition for when signal isn't length 1

    if N>1

        % extract even and odd
        even = signal(1:2:N);
        odd = signal(2:2:N);

        % create recursive calls on half-signals
        even_fft = ffth(even);
        odd_fft = ffth(odd);

        % set up the fft like we did in class.
        % the reason it goes from k = 0 to N/2-1 and then changes is
        % because N only covers half of the signal, and the signal is
        % periodic by N/2, thus you have to split the sum into two sections
        % to cover all of the k values.

        for k = 0:(N/2)-1
            fft1(k+1) = even_fft(k+1)+exp(-1j*2*pi/N*k)*odd_fft(k+1);
        end

        % twiddle factor becomes negative because there is a shift of N/2
        % in the exponent which can be simplified to -1 (done on paper)
        for k = (N/2):(N-1)
            fft1(k+1) = even_fft(k-N/2+1)-exp(-2*pi*1j*(k-N/2)/N)*odd_fft(k-N/2+1);
        end
    % create condition for breaking out of recursion
    else
        fft1 = signal;
    end
end

