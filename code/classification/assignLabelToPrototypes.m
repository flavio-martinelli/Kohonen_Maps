function Results = assignLabelToPrototypes(Data, Results)

Results.counts = getDigitCountInPrototypes(Data, Results.centers);
Results.labelOfClusters = extractLabelsFromCounts(Results.counts, Data.labelSet);
Results.digitOfClusters = convertLabelsToDigits(Results.labelOfClusters , Data.data, Data.labels);

end

