function visualizeUpdateSteps(updateSteps, updateStepMean, updateStepMeanDelta, iteration, Params, figureIndex)

figure(figureIndex)

subplot(311)
plot(updateSteps(1:iteration))
xlabel('iterations')
legend('||centers_{old} - centers_{new}||')
grid on

subplot(312)
plot((1:length(updateStepMean))*Params.updateMeanWindow, updateStepMean)
xlabel('iterations')
legend('mean')
grid minor

subplot(313)
plot((2:length(updateStepMeanDelta)+1)*Params.updateMeanWindow, updateStepMeanDelta)
xlabel('iterations')
legend('mean difference')
grid minor

end

