function visualizeUpdateSteps(updateSteps, updateStepMean, updateStepMeanDelta, iteration, Params, figureIndex)

figure(figureIndex)

subplot(311)
plot(updateSteps(1:iteration))
xlabel('iterations')
title('||centers_{old} - centers_{new}||')
grid on

subplot(312)
plot((1:length(updateStepMean))*Params.tolUpdateMeanWindow, updateStepMean)
xlabel('iterations')
title('mean')
grid minor

subplot(313)
plot((2:length(updateStepMeanDelta)+1)*Params.tolUpdateMeanWindow, updateStepMeanDelta)
xlabel('iterations')
title('mean difference')
grid minor

end

