function [I,bandNum] = bandVisualization(V, W, bandNum, method)
% Channels covering the wavelengths from 400 nm to 700 nm for the RGB.
switch method
    case {'rgb', 'cir'}
        % Check if data is having RGB or CIR wavelengths.
        if isempty(bandNum)
            %  Divide R, G and B bands according to their wavelength range.
            rbands = hasWavelength(W, {'red'});
            gbands = hasWavelength(W, {'green'});

            % Find the closest wavelength from 650 nm for R band and 550 nm
            % for G band.
            [~, nearestRband] = min(abs(W(rbands)-650));
            [~, nearestGband] = min(abs(W(gbands)-550));

            % Get the closest band location of R and G channels.
            nearestRband = nearestRband + find(rbands,1) - 1;
            nearestGband = nearestGband + find(gbands,1) - 1;

            if strcmpi(method, 'rgb')
                % Divide B band according to their wavelength range.
                bbands = hasWavelength(W, {'blue'});

                % Find the closest wavelength from 470 nm for B band.
                [~, nearestBband] = min(abs(W(bbands)-470));

                % Get the closest band location of B channels.
                nearestBband = nearestBband + find(bbands,1) - 1;
            else
                % Colored Infrared (CIR) color composite.
                % Divide spectral ranges into near infrared(NIR), R and G.
                % This method is more suitable to show vegetation in an
                % image.
                bbands = hasWavelength(W, {'NIR'});

                % Find the closest wavelength from 860 nm for NIR band.
                [~, nearestBband] = min(abs(W(bbands)-860));

                % Get the closest band location of NIR channels.
                nearestBband = nearestBband + find(bbands,1) - 1;
            end

            R = nearestRband;
            G = nearestGband;
            B = nearestBband;


        end

        if strcmpi(method, 'rgb')
            % Check if B band is empty or not.
            if isempty(B)
                error(message('hyperspectral:hypercube:mustHaveBlueChannelWavelength'));
            end
        else
            % Check if NIR band is empty or not.
            if isempty(B)
                error(message('hyperspectral:hypercube:mustHaveNIRChannelWavelength'));
            end
        end

        % Check if G band is empty or not.
        if isempty(G)
            error(message('hyperspectral:hypercube:mustHaveGreenChannelWavelength'));
        end

        % Check if R band is empty or not.
        if isempty(R)
            error(message('hyperspectral:hypercube:mustHaveRedChannelWavelength'));
        end


        if strcmpi(method, 'rgb')
            bandNum = [R G B];
            [image1, image2, image3] = getImagePlanes(V, bandNum);

        else

            % For CIR method order should be NIR-R-G bands.
            bandNum = [B R G];
            [image1, image2, image3] = getImagePlanes(V, bandNum);

        end


    case 'falseColored'
        % Considering first three bands are most uncorrelated three bands in
        % hyperspectral data. So, extract first three bands from the
        % selectBands method.
        [image1, image2, image3] = getImagePlanes(V, bandNum);

end

I = stretching(image1, image2, image3);
end

function [image1, image2, image3] = getImagePlanes(V, bandNum)
image1 = V(:,:,bandNum(1));
image2 = V(:,:,bandNum(2));
image3 = V(:,:,bandNum(3));
end

function I = stretching(image1, image2, image3)
% Enhance the colored image using adaptive histogram equalization method.

% Concatenate three images
I = cat(3,image1,image2,image3);

if isinteger(I)
    I=single(I);
end

for n=1:3
    stretchedImg = rescale(I(:,:,n));
    I(:,:,n)=adapthisteq(stretchedImg); % Contrast stretched image.
end
end