function estimatedLabels = getLabelsFromDigits(digits, network, labels)

numberOfDigits = size(digits,1);
estimatedLabels = zeros(numberOfDigits,1);

for d=1:numberOfDigits
    estimatedLabels(d) = getLabelFromOneDigit(digits(d,:), network, labels);
end

end

