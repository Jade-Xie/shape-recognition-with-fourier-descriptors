function [ prototype_pattern_vectors ] = generate_prototype_vectors( image_names )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
for id=1:length(image_names)-1
    curr_image = strcat('../images/',image_names{id},'.jpg');
    BinaryImage = load_image(curr_image);
    CCImage = label_image(BinaryImage);
    NumOfObjects = numel(unique(CCImage))-1;
    z = cell(2,1);
    for n=1:NumOfObjects
        [contour, row, col]  = trace_boundary(BinaryImage,CCImage,n);
%         [contour, row, col]  = trace_boundary_matlab(BinaryImage,CCImage,n);
        z{n} = contour(:,2)-1i*contour(:,1);
        pattern_vector(:,n) = [generate_pattern_vector(z{n})]';
    end
    prototype_pattern_vectors{id} = pattern_vector;
end

end

