function [ general_shape_features, test_label ] = generate_general_shape_features( image_names )
%generate_general_shape_features: Shape classification using general shape
%features
img = [];
for id=1:length(image_names)
    if (id==length(image_names))
        test_image = strcat('../images/',image_names{id},'.jpg');
        BinaryTestImage =  load_image(test_image);
        CCTestImage = label_image(BinaryTestImage);
        img = CCTestImage;
        Area_stats = regionprops(CCTestImage,'Area');
        Perimeter_stats = regionprops(CCTestImage,'Perimeter');
        BoundingBox_stats = regionprops(CCTestImage,'BoundingBox');
        EquivDiameter_stats = regionprops(CCTestImage,'EquivDiameter');
        MajorAxis_stats = regionprops(CCTestImage,'MajorAxisLength');
        MinorAxis_stats = regionprops(CCTestImage,'MinorAxisLength');
        Eccentricity_stats = regionprops(CCTestImage,'Eccentricity');
        for n=1:length(Area_stats)
            pattern_test_vector(1,n) = Perimeter_stats(n).Perimeter^2/(4*pi*Area_stats(n).Area);    % compactness
            pattern_test_vector(2,n) = Area_stats(n).Area/prod(BoundingBox_stats(n).BoundingBox(3:4));  % rectangularity
            pattern_test_vector(3,n) = Area_stats(n).Area/Perimeter_stats(n).Perimeter;
            pattern_test_vector(4,n) = Area_stats(n).Area/EquivDiameter_stats(n).EquivDiameter;  % circularity
            pattern_test_vector(5,n) = MajorAxis_stats(n).MajorAxisLength/MinorAxis_stats(n).MinorAxisLength;
            pattern_test_vector(6,n) = Eccentricity_stats(n).Eccentricity;
        end
    else
        curr_image = strcat('../images/',image_names{id},'.jpg');
        BinaryImage = load_image(curr_image);
        CCImage = label_image(BinaryImage);
        Area_stats = regionprops(CCImage,'Area');
        Perimeter_stats = regionprops(CCImage,'Perimeter');
        BoundingBox_stats = regionprops(CCImage,'BoundingBox');
        EquivDiameter_stats = regionprops(CCImage,'EquivDiameter');
        MajorAxis_stats = regionprops(CCImage,'MajorAxisLength');
        MinorAxis_stats = regionprops(CCImage,'MinorAxisLength');
        Eccentricity_stats = regionprops(CCImage,'Eccentricity');
        for n=1:length(Area_stats)
            pattern_vector(1,n) = Perimeter_stats(n).Perimeter^2/(4*pi*Area_stats(n).Area);
            pattern_vector(2,n) = Area_stats(n).Area/prod(BoundingBox_stats(n).BoundingBox(3:4));  % rectangularity
            pattern_vector(3,n) = Area_stats(n).Area/Perimeter_stats(n).Perimeter;
            pattern_vector(4,n) = Area_stats(n).Area/EquivDiameter_stats(n).EquivDiameter;
            pattern_vector(5,n) = MajorAxis_stats(n).MajorAxisLength/MinorAxis_stats(n).MinorAxisLength;
            pattern_vector(6,n) = Eccentricity_stats(n).Eccentricity;
        end
        general_shape_features{id} = pattern_vector;
    end
end

Train_vectors = cell2mat(general_shape_features);
NumOfTestObjects =  numel(unique(CCTestImage))-1;
test_label = zeros(NumOfTestObjects,1);

Train_vectors = normc(Train_vectors);
pattern_test_vector = normc(pattern_test_vector);

for n=1:NumOfTestObjects
    D = bsxfun(@minus,Train_vectors,pattern_test_vector(:,n));
    [~,index] = min(sqrt(sum(D.^2,1)));
    test_label(n) = ceil(index/10);
end

for l=1:numel(unique(test_label))
    cls = find(test_label==l);
    for i=1:length(cls)
        img(CCTestImage==cls(i)) = l;
    end
end

figure('Name','Task9','NumberTitle','off');
imagesc(img/3), title('Shape classification using general shape features'), colormap('jet'), colorbar


end

