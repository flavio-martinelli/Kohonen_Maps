close all
clear variables
clc

gitHubDirectory = erase(pwd, '\code');
setPath(gitHubDirectory)

%% data
Data = loadData('Tom');

%% train
Params = createParams(6, 1, false);
Results = trainNetwork(Data.data, Params);
Results = assignLabelToPrototypes(Data, Results);

visualizeNetwork(Results.centers, 'trained network', 101);
visualizeUpdateSteps(Results.updateSteps, Results.updateStepMean, Results.updateStepMeanDelta,  Params.maxIter, Params, 102)
visualizeNetwork(Results.digitOfClusters, 'learned labels in network', 202);
visualizeCounts(Results.counts, Data.targetdigits, 201)

%% optimize
ResultOptim = optimizeHyperparametersDistance(Data.data);
visualizeOptimizationResult(ResultOptim)

%% save 
saveAllFigures([gitHubDirectory, '\results\'], 'jpeg', Params, false)

subplot(6,6,1)
xlabel('counts')



