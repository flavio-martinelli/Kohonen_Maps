close all
clear variables
clc

gitHubDirectory = erase(pwd, '\code');
setPath(gitHubDirectory)

%% data
Data = loadData('Tom');

%% train
Params = createParams(8, 2, true);
Results = trainNetwork(Data.data, Params);
Results = assignLabelToPrototypes(Data, Results);

visualizeUpdateSteps(Results.updateSteps, Results.updateStepMean, Results.updateStepMeanDelta,  Params.maxIter, Params, 102)
visualizeNetwork(Results.centers, 'trained network', 101);
visualizeNetwork(Results.digitOfClusters, 'learned labels in network', 202);
visualizeCouResultOptim = optimizeHyperparametersDistance(Data.data);
nts(Results.counts, Data.targetdigits, 201)

%% optimize
visualizeOptimizationResult(ResultOptim)

%% save 
saveAllFigures([gitHubDirectory, '\results\'], 'jpeg', Params, false)





