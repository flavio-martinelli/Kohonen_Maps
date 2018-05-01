close all
clear variables
clc

Data = loadData('Tom');
Params = createParams(6,3);

Results = trainNetwork(Data.data, Params);
Results = assignDigitsToPrototypes(Data, Results);

visualizeTargetDigits(Data, Params, 1)
visualizeNetwork(Results.centers, 'trained network', 101);
visualizeLabelProbabilityInNetwork(Results.labelCountInPrototypes, Data.targetdigits, 201)
visualizeNetwork(Results.estimatedDataOfPrototypes, 'learned labels in network', 202);

% resultFolderPath = 'D:\Documents\etudes\epfl\cours\Unsupervised_and_Reinforcement_Learning_in_Neural_Networks\miniproject1\Kohonen_Maps\results\';
% saveAllFigures(resultFolderPath, 'jpeg', Params)

[h1Optimal, h2Optimal] = optimizeHyperparameters(Data.data);