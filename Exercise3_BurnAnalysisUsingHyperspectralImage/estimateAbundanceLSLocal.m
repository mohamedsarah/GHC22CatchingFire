function abundanceMap = estimateAbundanceLSLocal(cube,signatures)



% reshape the hypercube data for least square solution
[rows, cols, numBand] = size(cube);
cube = reshape(cube, [rows*cols, numBand]);
cube = double(cube');

% call main algorithm
signatures = double(signatures); % algorithm uses svd which accepts only double precision inputs
abundanceMapTemp = zeros(size(signatures,2),rows*cols);
sigInv = pinv(signatures);
for sample = 1:rows*cols
    abundanceMapTemp(:,sample) = sigInv*cube(:,sample);
end


% reshape back to hypercube data
abundanceMap = zeros(rows,cols,size(signatures,2));
for numEnd = 1:size(signatures,2)
    abundanceMap(:,:,numEnd) = reshape(abundanceMapTemp(numEnd,:),[rows cols]);
end
