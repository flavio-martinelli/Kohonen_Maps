function visualizeUpdateSteps(updateSteps, updateStepMean, updateStepMeanDelta, iteration, figureIndex)

figure(figureIndex)

subplot(311)
plot(updateSteps(1:iteration))
xlabel('iterations')
title('||centers_{old} - centers_{new}||')
grid on

subplot(312)
plot(updateStepMean(1:iteration))
xlabel('iterations')
title('mean(||centers_{old} - centers_{new}||) over')
grid on

subplot(313)
plot(updateStepMeanDelta(1:iteration))
xlabel('iterations')
title('mean difference over iteration')
grid on

pause(0.1)

end

