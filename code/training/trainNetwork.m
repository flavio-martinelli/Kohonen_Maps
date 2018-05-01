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
    
    if mod(iter, round(Params.maxIter/10)) == 0 || iter == 1
        disp(['iter: ', num2str(iter)])
    end
    
    i=iR(iter);
    new_centers = som_step(old_centers, data(i,:), Params.neighbor, Params.eta, Params.sigma);
    updateSteps(1,iter) = getUpdateStep(new_centers, old_centers);
    old_centers = new_centers;
    
    if mod(iter,Params.tolUpdateMeanWindow) == 0
        if iter >= Params.tolUpdateMeanWindow
            updateStepMean = [updateStepMean, mean(updateSteps(iter-Params.tolUpdateMeanWindow+1:iter)) ];
        end
        if iter>= 2*Params.tolUpdateMeanWindow
            updateStepMeanDelta = [updateStepMeanDelta, abs(updateStepMean(end) - updateStepMean(end-1))];
        end
    end
    
    if Params.displayTraining
        if mod(iter, Params.displayStep)==0 || iter==1
            visualizeNetwork(old_centers, ['network state at iteration: ', num2str(iter)], 101)
        end
        if mod(iter, Params.displayStep)==0 && iter>= 2*Params.tolUpdateMeanWindow
            visualizeUpdateSteps(updateSteps, updateStepMean, updateStepMeanDelta,  iter, Params, 102)
        end
    end
    
end

Results.centers = new_centers;
Results.updateSteps = updateSteps;
Results.updateStepMean = updateStepMean;
Results.updateStepMeanDelta = updateStepMeanDelta;

end

