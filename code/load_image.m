function [ I ] = load_image( filename )
%load_image : takes as an argument a file name and returns a binary image
%in a matrix form
thres = 20;
I = imread(filename);
I = I < thres;
kernel = [0 1 1 1 0;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;0 1 1 1 0];
I = imdilate(I,kernel);

end

