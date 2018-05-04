function ResultOptim = optimizeHyperparametersDistance(data)

% grid of hyperparameters
sizeKGrid = (6:10)
sigmaGrid = (1:5)
N1 = length(sizeKGrid);
N2 = length(sigmaGrid);

% number of folds
k_fold = 5;

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
            data_test = data(cp.test(k), :);
            
            % train
            Results = trainNetwork(data_training, Params);
            visualizeNetwork(Results.centers, 'trained network', 101);
            
            % error
            training_error(n1,n2,k) = computeDistanceDataToNetwork(data_training, Results.centers);
            test_error(n1,n2,k) = computeDistanceDataToNetwork(data_test, Results.centers);

        end
        
        disp(['training error = ', num2str(round(mean(training_error(n1,n2,:)),2))])
        disp(['test error = ', num2str(round(mean(test_error(n1,n2,:)),2))])

    end
end

% optimal hyperparameters
mean_test_error = mean(test_error,3);
min_test_error = min(mean_test_error(:));
[optimalSigma, optimalSizeK]= find(mean_test_error==min_test_error);

% store
ResultOptim.test_error = test_error;
ResultOptim.training_error = training_error;
ResultOptim.sizeKGrid = sizeKGrid;
ResultOptim.sigmaGrid = sigmaGrid; 
ResultOptim.optimalSigma = optimalSigma;
ResultOptim.optimalSizeK = optimalSizeK;

end

