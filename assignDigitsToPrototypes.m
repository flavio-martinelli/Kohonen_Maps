function Results = assignDigitsToPrototypes(Data, Results)

uniqueLabels = unique(Data.labels);
numberOfUniqueLabels = size(uniqueLabels,1);
numberOfData = size(Data.data,1);
numberOfPrototypes = size(Results.centers,1);
labelCountInPrototypes = zeros(numberOfPrototypes, numberOfUniqueLabels);
estimatedLabelOfPrototypes = zeros(numberOfPrototypes, 1);
estimatedDataOfPrototypes = zeros(numberOfPrototypes, size(Results.centers,2));
error = 0;

for dataIndex=1:numberOfData
    [distanceToPrototype, assignedPrototypeIndex] = assignOneDigitToOnePrototype(Data.data(dataIndex,:), Results.centers);
    labelOfData = Data.labels(dataIndex);
    indexInUniqueLabels = find(uniqueLabels == labelOfData);
    labelCountInPrototypes(assignedPrototypeIndex, indexInUniqueLabels) = labelCountInPrototypes(assignedPrototypeIndex, indexInUniqueLabels) + 1;
    error = error + distanceToPrototype;
end

for p=1:numberOfPrototypes
 [~, index] = max(labelCountInPrototypes(p,:));
 estimatedLabelOfPrototypes(p) = uniqueLabels(index);
 indicesOfDataWithEstimatedLabel = find(Data.labels==estimatedLabelOfPrototypes(p));
 estimatedDataOfPrototypes(p,:) = Data.data(indicesOfDataWithEstimatedLabel(1),:);
end

Results.labelCountInPrototypes = labelCountInPrototypes;
Results.estimatedLabelOfPrototypes = estimatedLabelOfPrototypes;
Results.estimatedDataOfPrototypes = estimatedDataOfPrototypes;
Results.error = error;

end

