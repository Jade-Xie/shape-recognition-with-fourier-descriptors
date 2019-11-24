%% Shape Recognition with Fourier Descriptors
% author: Hidir Yuzuguzel
clear all, close all
%% Global variables
shape_names = {'triangular_shapes','quadrandular_shapes','pentagon_shapes','test_image'};
image_names = {'img1','img2','img3','img4'};
idx = 1;    % index of current image
curr_image = strcat('../images/',image_names{idx},'.jpg');
test_image = strcat('../images/',image_names{end},'.jpg');
%% Task2 - Thresholding & pre-processing
BinaryImage = load_image(curr_image);
%% Task3 - Connected component labelling
CCImage = label_image(BinaryImage);
%% Task4 - Boundary tracing
NumOfObjects = numel(unique(CCImage))-1;    % substract the background
figure('Name','Task4','NumberTitle','off');
subplot(122), imshow(rgb2gray(label2rgb(CCImage))), title(strcat('Connected objects: ',shape_names{idx}))
subplot(121), imshow(BinaryImage), title(shape_names{idx})
z = cell(2,1);
for i=1:NumOfObjects
    [contour, row, col]  = trace_boundary(BinaryImage,CCImage,i);
    %[contour, row, col]  = trace_boundary_matlab(BinaryImage,CCImage,i);
    z{i} = contour(:,2)-1i*contour(:,1);

    if ~isempty(contour)
        hold on
        plot(contour(:,2),contour(:,1),'r','LineWidth',2);
        hold on;
        plot(col, row,'gx','LineWidth',2);
    end
    hold off
%     i
%     pause
end
%% Task 5 & Task 6 - Geneating pattern vectors and displaying the pattern vectors
display_pattern_vectors(curr_image);
%% Task 7 - Generating protoype pattern vectors
prototype_pattern_vectors = generate_prototype_vectors(image_names);
%% Task 8 - Classifying pattern vectors
test_label = classify_objects(test_image,prototype_pattern_vectors);
%% Task 9 - Experimental research (General shape features)
[~, general_shape_features_test_label] = generate_general_shape_features(image_names);
