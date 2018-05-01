function labelOfDigit = getLabelFromOneDigit(digit, network, labels)

% network size
sizeK = sqrt(size(network,1));

%find the best matching unit via the minimal distance to the datapoint
[~, assignedPrototypeIndex]=min(sqrt(sum(abs(network-repmat(digit,sizeK^2,1)).^2,2)));

% label of the prototype found
labelOfDigit = labels(assignedPrototypeIndex);

end

