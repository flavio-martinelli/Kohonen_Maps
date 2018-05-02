close all
clear variables
clc

gitHubDirectory = 'D:\Documents\etudes\epfl\cours\Unsupervised_and_Reinforcement_Learning_in_Neural_Networks\miniproject1\Kohonen_Maps';
setPath(gitHubDirectory)

%% data
Data = loadData('Tom');

%% train
Params = createParams(6, 2, true);
Results = trainNetwork(Data.data, Params);
Results = assignLabelToPrototypes(Data, Results);
visualizeUpdateSteps(Results.updateSteps, Results.updateStepMean, Results.updateStepMeanDelta,  Params.maxIter, Params, 102)
visualizeNetwork(Results.centers, 'trained network', 101);
visualizeNetwork(Results.estimatedCentroids, 'learned labels in network', 202);
visualizeCounts(Results.counts, Data.targetdigits, 201)

%% optimize
ResultOptim = optimizeHyperparameters(Data.data(1:100,:), Data.labels(1:100));
visualizeOptimizationResult(ResultOptim)

%% save 
saveAllFigures([gitHubDirectory, '\results\'], 'jpeg', Params, false)





