function counts = getDigitCountInPrototypes(Data, network)

labelSet = unique(Data.labels);
numberOfLabels = size(labelSet,1);
numberOfData = size(Data.data,1);
numberOfPrototypes = size(network,1);
counts = zeros(numberOfPrototypes, numberOfLabels);

for dataIndex=1:numberOfData
    labelOfData = Data.labels(dataIndex);
    indexLabel = find(Data.labelSet == labelOfData);
    [~, assignedPrototypeIndex] = assignOneDigitToOnePrototype(Data.data(dataIndex,:), network);
    counts(assignedPrototypeIndex, indexLabel) = counts(assignedPrototypeIndex, indexLabel) + 1;
end

end

