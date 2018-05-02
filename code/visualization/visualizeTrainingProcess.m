function visualizeTrainingProcess(Results,  iter, Params, figure1, figure2)

if mod(iter, Params.displayStep)==0 || iter==1
    visualizeNetwork(Results.centers, ['network state at iteration: ', num2str(iter)], figure1)
end

if mod(iter, Params.displayStep)==0 && iter>= 2*Params.updateMeanWindow && Params.computeUdpates
    visualizeUpdateSteps(Results.updateSteps, Results.updateStepMean, Results.updateStepMeanDelta,  iter, Params, figure2)
end

end

