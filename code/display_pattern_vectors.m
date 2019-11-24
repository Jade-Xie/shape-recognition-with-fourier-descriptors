function display_pattern_vectors( filename )
%display_pattern_vectors
L = 10;
BinaryImage = load_image(filename);
CCImage = label_image(BinaryImage);
NumOfObjects = numel(unique(CCImage))-1;    % substract the background
z = cell(2,1);
for i=1:NumOfObjects
    [contour, ~, ~]  = trace_boundary(BinaryImage,CCImage,i);
    z{i} = contour(:,2)-1i*contour(:,1);
end

figure('Name',sprintf('Pattern vectors of %s',filename),'NumberTitle','off'), 
for i=1:NumOfObjects
    pattern_vector(i,:) = generate_pattern_vector(z{i});
    subplot(2,5,i); 
    stem([-L:-1,2:L]',pattern_vector(i,:)), xlabel('L'), ylabel('x'), title('Fourier Descriptors')
end

end

