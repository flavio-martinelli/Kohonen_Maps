function ResultOptim = optimizeHyperparameters(data, labels)


% grid of hyperparameters
sizeKGrid = linspace(6,10,1); N1 = length(sizeKGrid);
sigmaGrid = linspace(1,5,5); N2 = length(sigmaGrid);

% number of folds
k_fold = 2;

%  cvpartition
numberOfData = size(data,1);
cp = cvpartition(numberOfData,'kfold', k_fold);

% store losses
error_train = zeros(N1, N2, k_fold);
error_test = zeros(N1, N2, k_fold);

for n1=1:N1
    
    for n2=1:N2
        
        disp('------------------------------------------')
        disp(['sizeK =', num2str(sizeKGrid(n1))])
        disp(['sigma =', num2str(sigmaGrid(n2))])

        % update parameters
        Params = createParams(sizeKGrid(n1), sigmaGrid(n2), false);
        
        for k=1:k_fold
            
            disp(['k-fold = ', num2str(k)])
            
            % datasets
            data_training = data(cp.training(k), :);
            data_test = data(cp.test(k), :);
            labels_training = labels(cp.training(k), :);
            labels_test = labels(cp.test(k), :);
            
            % structure
            Data_training.data = data_training;
            Data_training.labels = labels_training;
            Data_training.labelSet = unique(labels_training);
            Data_test.data = data_test;
            Data_test.labels = labels_test;
            Data_test.labelSet = unique(labels_test);
            
            % train
            Results = trainNetwork(data_training, Params);
            Results = assignLabelToPrototypes(Data_training, Results.centers);

            % predict
            estimated_labels_training = getLabelsFromDigits(data_training, Results.estimatedCentroids, Results.estimatedLabels);
            estimated_labels_test = getLabelsFromDigits(data_test, Results.estimatedCentroids, Results.estimatedLabels);
            
            % error
            error_train(n1,n2,k) = getClassError(labels_training, estimated_labels_training);
            error_test(n1,n2,k) = getClassError(labels_test, estimated_labels_test);

        end
    end
end

% mean and var losses
mean_training_error = mean(error_train, 3); var_training_error = var(error_train, 0, 3);
mean_testing_error = mean(error_test, 3); var_test_error = var(error_test, 0, 3);

% optimal hyperparameters
[~, minimalErrorIndex] = min(mean_testing_error);
[optimalSigma, optimalSizeK] = ind2sub(size(mean_testing_error) , minimalErrorIndex);

% store
ResultOptim.mean_training_error = mean_training_error;
ResultOptim.mean_testing_error = mean_testing_error;
ResultOptim.var_training_error = var_training_error;
ResultOptim.var_test_error = var_test_error;
ResultOptim.sizeKGrid = sizeKGrid;
ResultOptim.sigmaGrid = sigmaGrid; 
ResultOptim.optimalSigma = optimalSigma;
ResultOptim.optimalSizeK = optimalSizeK;

end

