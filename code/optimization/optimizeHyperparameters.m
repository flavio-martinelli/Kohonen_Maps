function [h1Optimal, h2Optimal] = optimizeHyperparameters(data)


% grid of hyperparameters
h1Grid = linspace(6,10,1); Nh1 = length(h1Grid);
h2Grid = linspace(1,5,5); Nh2 = length(h2Grid);

% number of folds
k_fold = 10;

%  cvpartition
numberOfData = size(data,1);
cp = cvpartition(numberOfData,'kfold', k_fold);

% store losses
error_train = zeros(Nh1, Nh2, k_fold);
error_test = zeros(Nh1, Nh2, k_fold);

for n1=1:Nh1
    
    for n2=1:Nh2
        
        disp(['sizeK =', num2str(h1Grid(n1))])
        disp(['sigma =', num2str(h2Grid(n2))])

        % update parameters
        Params = createParams(h1Grid(n1), h2Grid(n2));
        
        for k=1:k_fold
            
            % datasets
            data_training = data(cp.training(k), :);
            data_test = data(cp.test(k), :);
            
            % train
            Results = trainNetwork(data_training, Params);
            Results = assignDigitsToPrototypes(data_training, Results);

            % errors
            error_train(n1,n2,k) = gerError(data_training, Results.centers);
            error_test(n1,n2,k) = gerError(data_test, Results.centers);
            
        end
    end
end

% mean and var losses
mean_error_training = mean(error_train, 3); var_loss_training = var(error_train, 0, 3);
mean_error_testing = mean(error_test, 3); var_loss_test = var(error_test, 0, 3);

% optimal hyperparameters
[~, minimalErrorIndex] = min(mean_error_testing);
[h1Optimal, h2Optimal] = ind2sub(size(mean_error_testing) , minimalErrorIndex);

% plot with error bar
figure; hold on
errorbar(mean_error_training(:), var_loss_training(:), 'b-')
errorbar(mean_error_testing(:), var_loss_test(:), 'r-')
xlabel('hyperparameter set index')
ylabel('error')
legend('train', 'test')

end

