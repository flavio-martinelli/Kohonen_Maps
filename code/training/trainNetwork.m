function Results = trainNetwork(data, Params)

rng(Params.seed)
centers = rand(Params.sizeK^2,Params.dim)*Params.range;
iR=mod(randperm(Params.maxIter), size(data, 1)+1); iR(iR==0) = 1;
updateSteps = zeros(1, Params.maxIter);
updateStepMean = [];
updateStepMeanDelta = [];
old_centers = centers;

% stopping criteria = iteration
for t=1:Params.maxIter
    
    i=iR(t);
    new_centers = som_step(old_centers, data(i,:), Params.neighbor, Params.eta, Params.sigma);
    updateSteps(1,t) = getUpdateStep(new_centers, old_centers);
    old_centers = new_centers;
    
    if mod(t,Params.tolUpdateMeanWindow) == 0
        if t >= Params.tolUpdateMeanWindow
            updateStepMean = [updateStepMean, mean(updateSteps(t-Params.tolUpdateMeanWindow+1:t)) ];
        end
        if t>= 2*Params.tolUpdateMeanWindow
            updateStepMeanDelta = [updateStepMeanDelta, abs(updateStepMean(end) - updateStepMean(end-1))];
        end
    end
    
    if Params.displayTraining
        if mod(t, Params.displayStep)==0 || t==1
            visualizeNetwork(old_centers, ['network state at iteration: ', num2str(t)], 101)
        end
        if mod(t, Params.displayStep)==0 && t>= 2*Params.tolUpdateMeanWindow
            visualizeUpdateSteps(updateSteps, updateStepMean, updateStepMeanDelta,  t, Params, 102)
        end
    end
    
end

Results.centers = new_centers;
Results.updateSteps = updateSteps;

end

