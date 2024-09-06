clc; clear all; close all;

%% Load the license plate image
plate = imread('D:\AAST\10th))))))\DSP\license1.jpg');

figure
subplot(221)
imshow(plate)
title('Original')

%% Preprocessing

gray = rgb2gray(plate);
subplot(222)
imshow(gray)
title('Gray Scale')
gray= medfilt2(gray);


%Binarize
bim= gray>128;
grayedge=edge(bim, 'Canny');

subplot(223)
imshow(grayedge)
title('Binarized')

%Structure
se = strel('rectangle', [2 2]);
%se = strel('disk', 3);

%open = imopen(grayedge, se);
%open= imclose(grayedge, se);
open=imdilate(grayedge, se);

subplot(224)
imshow(open)
title('Structured')


% Segmentation
cc = bwconncomp(open);
props = regionprops(cc, 'BoundingBox', 'Area')

characters = cell(cc.NumObjects, 1);
for i = 1:cc.NumObjects
    charBoundingBox = props(i).BoundingBox;
    character = imcrop(open, charBoundingBox);
    characters{i} = character;
end

% areas = [props.Area];
% sortedArea=sort(areas,'descend');
% 
% idx1 = find(areas == sortedArea(1));
% idx2 = find(areas == sortedArea(2));
% 
% bbox1 = props(idx1).BoundingBox;
% bbox2 = props(idx2).BoundingBox;
% 
% plate_chars = imcrop(open, bbox1);
% plate_number = imcrop(open, bbox2);

figure
% subplot(222)
% imshow(plate_chars )
% title('Plate Characters')
% 
% subplot(221)
% imshow(plate_number )
% title('Plate Number')
% 
% % Feature extraction
% [m,n] = bwlabel(plate_chars,8);
% subplot(223)
% imshow(m )
% title('Plate Char. label')
%props = regionprops(char_label, 'all');
% features = [];
% for i = 1:length(props)
%     features = [features props(i).Area props(i).Eccentricity];
% end


% Recognition
%load trainedClassifier.mat % Load a pre-trained classifier
%label = predict(trainedClassifier, features);

% % Display the result
% imshow(plate)
% text(bbox(1), bbox(2)-20, label, 'Color', 'green', 'FontSize', 16)
% rectangle('Position', bbox, 'EdgeColor', 'green', 'LineWidth', 2)
