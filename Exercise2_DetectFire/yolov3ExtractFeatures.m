function activation = yolov3ExtractFeatures(in)

%   Copyright 2022 The MathWorks, Inc.

try
    activation = yolov3.extractFeatures(in);
catch
    activation = helper.extractFeatures(in);
end
