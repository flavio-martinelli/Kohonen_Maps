function visualizeTrainedNetwork(Results, Params)

figure

for i=1:Params.sizeK^2
    subplot(Params.sizeK,Params.sizeK,i)
    imagesc(reshape(Results.centers(i,:),28,28)')
    colormap gray
    axis off
end

suptitle('Centers of the trained network')

end

