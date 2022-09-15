function activation = extractFeatures(in)
    warning('off');
    s = load('helper/detector22a.mat');
    warning('on');
    try 
        yolov3Detector = s.yolov3Detector;
        featureExtractor = yolov3Detector.Network;
        activation = predict(featureExtractor, in, 'Outputs', 'conv2d_2');
    catch % If the detector cannot be loaded
         activation = s.activation;
    end
end