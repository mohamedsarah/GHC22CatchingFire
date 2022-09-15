function varargout = hasWavelength(wavelengths, bandNames)
%   Notes
%   -----
%   [1] Wavelengths values must be in Nanometers.
%
%   Standard Band Definition(in nanometers)
%   --------------------------------------
%   Band      Min(LB)      Center      Max(UB)
%   ----      ------       ------      ------
%   Blue      400          470         500
%   Green     500          550         600
%   Red       600          650         700
%   NIR       760          860         960
%   SWIR1     1550         1650        1750
%   SWIR2     2080         2220        2350
%
arguments
    wavelengths (:,1) {mustBeNumeric, mustBeNonNan, mustBeFinite,...
        mustBeNonsparse, mustBeNonempty, mustBeReal, mustBePositive}
    bandNames (:, 1) string {mustBeNonempty, mustBeASubset(bandNames)}
end

% Convert index names to lower case
bandNames = lower(bandNames);

% Calculate number of output variables
numOut = numel(bandNames);
varargout = cell(1, numOut);

for idx = 1:numOut
    switch bandNames(idx)
        case 'red'
            lb = 600;
            ub = 700;
        case 'green'
            lb = 500;
            ub = 600;
        case 'blue'
            lb = 400;
            ub = 500;
        case 'nir'
            lb = 760;
            ub = 960;
        case 'swir1'
            lb = 1550;
            ub = 1750;
        case 'swir2'
            lb = 2080;
            ub = 2350;
    end
    varargout{idx} = and(wavelengths >= lb, wavelengths <= ub);
end
end

function mustBeASubset(input)
for idx = 1:length(input)
    validatestring(input(idx), ["red", "green", "blue", "nir", "swir1",...
        "swir2"]);
end
end