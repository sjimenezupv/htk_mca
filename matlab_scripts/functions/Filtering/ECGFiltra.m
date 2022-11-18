function [ c ] = ECGFiltra( a, sr )

% http://electronicayciencia.blogspot.com.es/2011/09/electrocardiograma-y.html

     % normalizamos  
     %a=a/max(abs(a));  
       
     %obtenemos la FFT:  
     b  = fft(a);       % b es la fft de a  
     np = numel(b) / 2; % np numero de puntos;  
     b  = b(1:np);      % truncamos la fft  
       
     % cancelamos la red y sus armónicos:  
%      for i=101:100:sr/2; % 100 es para este caso, ver texto*  
%       b(i) = (b(i-1) + b(i+1)) / 2;  
%      end  
       
     f_bw  = (sr/2 / np);  
     f = [0:f_bw:sr/2-f_bw];  
      
     b = b .* gauss(f', 1, 0, 20);  
       
     % reobtenemos la forma de onda filtrada  
     b = [b ; 0 ; conj(flip(b(2:np)))]; % completamos la FFT  
     c = real(ifft(b)); % nos quedamos sólo la parte real  
     %c = c/max(abs(c)); % normalizamos
     
     %return;
     n = 3;
     w = linspace(0, 1, n);
     w = w(2:end-1);
     w = [w, 1.0, flip(w)]';     
     sw = 1 / sum(w);
     n = n-2;
     %%%%%% CORREGIR, NO ES CORRECTO!!!!!
     c = zeros(size(a));
     sz = (n * 2) + 1;
     for i = sz : length(a) - sz
          c(i) = mean(a(i-n:i+n) .* w);
          %c(i) = sum(a(i-n:i+n) .* w);
          %c(i) = (a(i-n:i+n)' * w) / sz;
     end
     
%      c = a;
%      sz = 4;
%      for i = 1 : length(a) - sz
%          c(i) = mean(a(i:i+sz));
%      end
     
%      size(a)
%      size(c)
%      plot(c)
     
     
end  
      
% filtro gausiano paso bajo  
function g = gauss(x, a, b, c)  
     % a: multiplicador  
     % b: media  
     % c: anchura  
     g = a .* exp(-(x-b).^2/c.^2);
end