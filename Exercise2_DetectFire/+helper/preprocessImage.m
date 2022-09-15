function [I, bboxes] = preprocessImage(I, bboxes, targetSize)
% Resize the images and scale the pixels to between 0 and 1. Also scale the
% corresponding bounding boxes.

imgSize = size(I);

% Convert an input image with single channel to 3 channels.
if numel(imgSize) < 3 
    I = repmat(I,1,1,3);
end
bboxes(bboxes==0) = 1;

I = imresize(I,targetSize(1:2));
scale = targetSize(1:2)./imgSize(1:2);
bboxes = bboxresize(bboxes,scale);

end