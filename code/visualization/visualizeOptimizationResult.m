function visualizeOptimizationResult(ResultOptim)

% mean and var losses
mean_training_error = mean(ResultOptim.training_error, 3);
mean_test_error = mean(ResultOptim.test_error, 3); 
var_training_error = var(ResultOptim.training_error, 0, 3);
var_test_error = var(ResultOptim.test_error, 0, 3);

% imagesc
figure
imagesc(ResultOptim.sigmaGrid, ResultOptim.sizeKGrid, mean_test_error)
set(gca,'YDir','normal')

xlabel('sigma neighborhood','FontSize',12,'FontWeight','bold')
ylabel('network size','FontSize',12,'FontWeight','bold')

h = colorbar;
ylabel(h, 'test error','FontSize',10,'FontWeight','bold')

end

