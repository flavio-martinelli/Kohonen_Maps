function visualizeTrainingProcess(centers, iter, Params, figure1, figure2)

if mod(iter, Params.displayStep)==0 || iter==1
    visualizeNetwork(centers, ['network state at iteration: ', num2str(iter)], figure1)
end
if mod(iter, Params.displayStep)==0 && iter>= 2*Params.tolUpdateMeanWindow
    visualizeUpdateSteps(updateSteps, updateStepMean, updateStepMeanDelta,  iter, Params, figure2)
end

end

