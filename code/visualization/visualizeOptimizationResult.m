function visualizeOptimizationResult(ResultOptim)

figure 
hold on
errorbar(ResultOptim.mean_training_error(:), ResultOptim.var_training_error(:), 'b-')
errorbar(ResultOptim.mean_testing_error(:), ResultOptim.var_test_error(:), 'r-')
xlabel('hyperparameter set index')
ylabel('error')
legend('train', 'test')


end

