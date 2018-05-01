function Results = assignDigitsToPrototypes(Data, Results)

labelSet = unique(Data.labels);
numberOfLabels = size(labelSet,1);
numberOfData = size(Data.data,1);
numberOfPrototypes = size(Results.centers,1);
counts = zeros(numberOfPrototypes, numberOfLabels);

for dataIndex=1:numberOfData
    labelOfData = Data.labels(dataIndex);
    indexLabel = find(Data.labelSet == labelOfData);
    [~, assignedPrototypeIndex] = assignOneDigitToOnePrototype(Data.data(dataIndex,:), Results.centers);
    counts(assignedPrototypeIndex, indexLabel) = counts(assignedPrototypeIndex, indexLabel) + 1;
end

estimatedLabels = extractLabelsFromCounts(counts, Data.labelSet);
estimatedCentroids = convertLabelsToDigits(estimatedLabels, Data.data, Data.labels);

Results.counts = counts;
Results.estimatedLabels = estimatedLabels;
Results.estimatedCentroids = estimatedCentroids;

end

