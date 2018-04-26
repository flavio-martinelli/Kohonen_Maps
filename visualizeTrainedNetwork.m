function visualizeTrainedNetwork(centers, title, figureIndex)

sizeK = sqrt(size(centers,1));

figure(figureIndex)

for i=1:sizeK^2
    subplot(sizeK,sizeK,i)
    imagesc(reshape(centers(i,:),28,28)')
    colormap gray
    axis off
end

suptitle(title)

end

