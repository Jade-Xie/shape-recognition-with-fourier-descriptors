function [ CCImage ] = label_image( BinaryImage )
%label_image Connected component labelling 
% P.S. I did not end up with sufficiently small area that's why I did not
% need to do any fragment removal.
CCImage = bwlabel(BinaryImage,4);

end

