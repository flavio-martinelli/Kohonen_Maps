function Results = assignLabelToPrototypes(Data, Results)

    Results.counts = getDigitCountInPrototypes(Data, Results.centers);
    Results.estimatedLabels = extractLabelsFromCounts(Results.counts, Data.labelSet);
    Results.estimatedCentroids = convertLabelsToDigits(Results.estimatedLabels , Data.data, Data.labels);

end

