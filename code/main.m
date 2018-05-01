close all
clear variables
clc

gitHubDirectory = 'D:\Documents\etudes\epfl\cours\Unsupervised_and_Reinforcement_Learning_in_Neural_Networks\miniproject1\Kohonen_Maps';
setPath(gitHubDirectory)

%% init
Data = loadData('Tom');
Params = createParams(6, 3, true);

%% train
Results = trainNetwork(Data.data, Params);
Results = assignLabelToPrototypes(Data, Results.centers);
visualizeTargetDigits(Data, Params, 1)
visualizeNetwork(Results.centers, 'trained network', 101);
visualizeNetwork(Results.estimatedCentroids, 'learned labels in network', 202);
visualizeCounts(Results.counts, Data.targetdigits, 201)
saveAllFigures([gitHubDirectory, '\results\'], 'jpeg', Params, false)

%% optimize
ResultOptim = optimizeHyperparameters(Data.data, Data.labels);





