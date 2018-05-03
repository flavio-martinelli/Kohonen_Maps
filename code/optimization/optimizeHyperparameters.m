function ResultOptim = optimizeHyperparameters(data, labels)

% grid of hyperparameters
sizeKGrid = linspace(6,10,5)
sigmaGrid = linspace(2,6,5)
N1 = length(sizeKGrid);
N2 = length(sigmaGrid);

% number of folds
k_fold = 200

%  cvpartition
numberOfData = size(data,1);
cp = cvpartition(numberOfData,'kfold', k_fold);

% store losses
training_error = zeros(N1, N2, k_fold);
test_error = zeros(N1, N2, k_fold);

for n1=1:N1
    
    for n2=1:N2
        
        disp('------------------------------------------')
        disp(['sizeK = ', num2str(sizeKGrid(n1))])
        disp(['sigma = ', num2str(sigmaGrid(n2))])

        % update parameters
        Params = createParams(sizeKGrid(n1), sigmaGrid(n2), false);
        
        for k=1:k_fold
            
            disp(['  k-fold = ', num2str(k)])
            
            % datasets
            data_training = data(cp.training(k), :);
            labels_training = labels(cp.training(k), :);
            data_test = data(cp.test(k), :);
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
            visualizeNetwork(Results.centers, 'trained network', 101);
            Results = assignLabelToPrototypes(Data_training, Results);

            % predict
            estimated_labels_training = getLabelsFromDigits(data_training, Results.digitOfClusters, Results.labelOfClusters);
            estimated_labels_test = getLabelsFromDigits(data_test, Results.digitOfClusters, Results.labelOfClusters);
            
            % error
            training_error(n1,n2,k) = getClassError(labels_training, estimated_labels_training);
            test_error(n1,n2,k) = getClassError(labels_test, estimated_labels_test);
            
            clear Results
            clear Data_training
            clear Data_test

        end
        
        disp(['training error = ', num2str(round(mean(training_error(n1,n2,:)),2)*100), ' %'])
        disp(['test error = ', num2str(round(mean(test_error(n1,n2,:)),2)*100), ' %'])

    end
end

% optimal hyperparameters
[~, minimalErrorIndex] = min(mean(test_error,3));
[optimalSigma, optimalSizeK] = ind2sub(size(test_error) , minimalErrorIndex);

% store
ResultOptim.test_error = test_error;
ResultOptim.training_error = training_error;
ResultOptim.sizeKGrid = sizeKGrid;
ResultOptim.sigmaGrid = sigmaGrid; 
ResultOptim.optimalSigma = optimalSigma;
ResultOptim.optimalSizeK = optimalSizeK;

end

