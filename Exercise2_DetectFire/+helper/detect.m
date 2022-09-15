function [bboxes, scores, labels] = detect(in, thresh)
    warning('off');
    s = load('helper/detector22a.mat');
    warning('on');
    try 
        yolov3Detector = s.yolov3Detector;
        [bboxes, scores, labels] = yolov3Detector.detect(in, 'Threshold', thresh);
    catch % If the detector cannot be loaded
         bboxes = s.bboxes;
         scores = s.scores;
         labels = s.labels;
    end
end