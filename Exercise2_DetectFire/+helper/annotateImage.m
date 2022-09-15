function bbox = annotateImage(I)
    I = imshow(I);
    title('Close the figure when you are done drawing bounding boxes.');
    bbox = [];
    roi = drawrectangle('Color', [1 0 0]); 
    while isvalid(roi)
        bbox = [bbox; roi.Position];        
        roi = drawrectangle('Color', [1 0 0]);
    end
end