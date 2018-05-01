function visualizeCounts(labelCount, labelNames, figureIndex)

sizeK = sqrt(size(labelCount,1));

figure(figureIndex)
labelNames = categorical(string(labelNames));

for i=1:sizeK^2
    subplot(sizeK,sizeK,i)
    bar(labelNames, labelCount(i,:))
    ylabel('counts')
    xlabel('labels')
    grid minor
end

end

