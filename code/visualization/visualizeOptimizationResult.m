function visualizeOptimizationResult(ResultOptim)

% mean and var losses
mean_training_error = mean(ResultOptim.training_error, 3);
mean_test_error = mean(ResultOptim.test_error, 3); 
var_training_error = var(ResultOptim.training_error, 0, 3);
var_test_error = var(ResultOptim.test_error, 0, 3);

% errorbar
figure 
hold on
errorbar(mean_training_error(:), var_training_error(:), 'b-')
errorbar(mean_test_error(:), var_test_error(:), 'r-')
xlabel('hyperparameter set index')
ylabel('error')
legend('train', 'test')

% imagesc
figure
imagesc(ResultOptim.sizeKGrid, ResultOptim.sigmaGrid, mean_test_error)
xlabel('network size')
ylabel('sigma neighborhood')
h = colorbar;
ylabel(h, 'test error')

end

