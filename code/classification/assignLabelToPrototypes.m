function Results = assignLabelToPrototypes(Data, centers)

Results.counts = getDigitCountInPrototypes(Data, centers);
Results.estimatedLabels = extractLabelsFromCounts(Results.counts, Data.labelSet);
Results.estimatedCentroids = convertLabelsToDigits(Results.estimatedLabels , Data.data, Data.labels);

end

