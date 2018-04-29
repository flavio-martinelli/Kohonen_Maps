function visualizeLabelsInNetwork(Data, Results)

sizeK = sqrt(size(Results.centers,1));

figure

subplot(121)
for i=1:sizeK^2
    subplot(sizeK,sizeK,i)
    digits_i = Data.data(Data.labels==Results.labelOfPrototypes(i),:);
    imagesc(reshape(digits_i(1,:),28,28)') 
    colormap gray
    axis off
end
title(

subplot(122)
for i=1:sizeK^2
    subplot(sizeK,sizeK,i)
    imagesc(reshape(Results.centers(i,:),28,28)')
    colormap gray
    axis off
end

suptitle(title)



end

