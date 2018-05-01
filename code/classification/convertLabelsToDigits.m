function digit = convertLabelsToDigits(estimatedLabels, dataRef, labelRef)

numberOfPrototypes = size(estimatedLabels, 1);
dim = size(dataRef,2);
digit = zeros(numberOfPrototypes, dim);

for p=1:numberOfPrototypes
    indices = find(labelRef==estimatedLabels(p));
    digit(p,:) = dataRef(indices(1),:);
end

end

