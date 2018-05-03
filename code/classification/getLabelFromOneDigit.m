function labelOfDigit = getLabelFromOneDigit(digit, centers, labelOfCenters)

% network size
sizeK = sqrt(size(centers,1));

%find the best matching unit via the minimal distance to the datapoint
[~, assignedPrototypeIndex]=min(sqrt(sum(abs(centers-repmat(digit,sizeK^2,1)).^2,2)));

% label of the prototype found
labelOfDigit = labelOfCenters(assignedPrototypeIndex);

end

