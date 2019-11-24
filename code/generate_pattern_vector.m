function [ pattern_vector ] = generate_pattern_vector( z )
%generate_pattern_vector Summary of this function goes here
%   Detailed explanation goes here
L = 10;
Z = fft(z);
pattern_vector = [[abs(Z(end-L:end-1))./abs(Z(2))]' [abs(Z(3:L+1))./abs(Z(2))]'];

end

