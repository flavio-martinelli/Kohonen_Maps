function Results = getUpdates(new_centers, Results, iter, Params)

Results.updateSteps(1,iter) = norm(new_centers - Results.centers);

if mod(iter,Params.updateMeanWindow) == 0
    if iter >= Params.updateMeanWindow
        Results.updateStepMean = [Results.updateStepMean, mean(Results.updateSteps(iter-Params.updateMeanWindow+1:iter)) ];
    end
    if iter>= 2*Params.updateMeanWindow
        Results.updateStepMeanDelta = [Results.updateStepMeanDelta, abs(Results.updateStepMean(end) - Results.updateStepMean(end-1))];
    end
end


end

