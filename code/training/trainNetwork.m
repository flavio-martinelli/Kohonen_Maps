function Results = trainNetwork(data, Params)

rng(Params.seed)
centers = rand(Params.sizeK^2,Params.dim)*Params.range;
iR=mod(randperm(Params.maxIter), size(data, 1)+1); iR(iR==0) = 1;
updateSteps = zeros(1, Params.maxIter);
updateStepMean = [];
updateStepMeanDelta = [];
old_centers = centers;

% stopping criteria = iteration
for iter=1:Params.maxIter
    
    if Params.displayTraining && (mod(iter, round(Params.maxIter/5)) == 0 || iter == 1)
        disp(['iter: ', num2str(iter)])
    end
    
    i=iR(iter);
    new_centers = som_step(old_centers, data(i,:), Params.neighbor, Params.eta, Params.sigma);
    old_centers = new_centers;
    
    if Params.computeUdpates
        [updateSteps, updateStepMean, updateStepMeanDelta] = getUpdates(new_centers, old_centers, updateSteps, updateStepMean, updateStepMeanDelta, iter, Params);
    end
    
    if Params.displayTraining
        visualizeTrainingProcess(old_centers, iter, Params, 101, 102)
    end
    
end

Results.centers = new_centers;
    if Params.computeUdpates
Results.updateSteps = updateSteps;
Results.updateStepMean = updateStepMean;
Results.updateStepMeanDelta = updateStepMeanDelta;

end

