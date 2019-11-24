function test_label = classify_objects(test_image,prototype_pattern_vectors)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
BinaryTestImage =  load_image(test_image);
CCTestImage = label_image(BinaryTestImage);
NumOfTestObjects = numel(unique(CCTestImage))-1;
img = CCTestImage;

z = cell(2,1);
% figure('Name','Classify objects','NumberTitle','off'), imshow(BinaryTestImage),
for n=1:NumOfTestObjects
    [contour, row, col]  = trace_boundary(BinaryTestImage,CCTestImage,n);
%     if ~isempty(contour)
%         hold on
%         plot(contour(:,2),contour(:,1),'r','LineWidth',2);
%         hold on;
%         plot(col, row,'gx','LineWidth',2);
%     end
%     hold off
%     n
%     pause
    z{n} = contour(:,2)-1i*contour(:,1);
    pattern_test_vector(:,n) = [generate_pattern_vector(z{n})]';
end

Train_vectors = cell2mat(prototype_pattern_vectors);

test_label = zeros(NumOfTestObjects,1);

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

figure('Name','Task8','NumberTitle','off');
imagesc(img/3), title('Shape classification using Fourier Descriptors'),
colormap('jet'), colorbar

end

