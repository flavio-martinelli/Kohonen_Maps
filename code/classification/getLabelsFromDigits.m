function estimatedLabels = getLabelsFromDigits(digits, centers, labelOfCenters)

numberOfDigits = size(digits,1);
estimatedLabels = zeros(numberOfDigits,1);

for d=1:numberOfDigits
    estimatedLabels(d) = getLabelFromOneDigit(digits(d,:), centers, labelOfCenters);
end

end

