function labels = extractLabelsFromCounts(counts, labelSet)

numberOfPrototypes = size(counts, 1);
labels = zeros(numberOfPrototypes, 1);

for p=1:numberOfPrototypes
 [~, index] = max(counts(p,:));
 labels(p) = labelSet(index);
end

end

