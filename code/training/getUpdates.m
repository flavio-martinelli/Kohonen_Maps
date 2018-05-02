function [updateSteps, updateStepMean, updateStepMeanDelta] = getUpdates(new_centers, old_centers, updateSteps, updateStepMean, updateStepMeanDelta, iter, Params)

updateSteps(1,iter) = norm(new_centers - old_centers);

if mod(iter,Params.updateMeanWindow) == 0
    if iter >= Params.updateMeanWindow
        updateStepMean = [updateStepMean, mean(updateSteps(iter-Params.updateMeanWindow+1:iter)) ];
    end
    if iter>= 2*Params.updateMeanWindow
        updateStepMeanDelta = [updateStepMeanDelta, abs(updateStepMean(end) - updateStepMean(end-1))];
    end
end


end

