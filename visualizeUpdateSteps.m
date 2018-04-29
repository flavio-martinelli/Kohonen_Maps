function visualizeUpdateSteps(updateSteps, updateStepMean, updateStepMeanDelta, iteration, figureIndex)

figure(figureIndex)

subplot(311)
plot(updateSteps(1:iteration))
xlabel('iterations')
title('||centers_{old} - centers_{new}||')
grid on

subplot(312)
plot(updateStepMean)
xlabel('iterations scaled')
title('mean')
grid on

subplot(313)
plot(updateStepMeanDelta)
xlabel('iterations scaled')
title('mean difference')
grid on

end

