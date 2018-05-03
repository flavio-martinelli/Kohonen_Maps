function labelOfDigit = getLabelFromOneDigit(digit, centers, labelOfCenters)

% assign
[~, assignedPrototypeIndex] = assignOneDigitToAPrototype(digit, centers);

% label of the prototype found
labelOfDigit = labelOfCenters(assignedPrototypeIndex);

end

