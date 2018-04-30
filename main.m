close all
clear variables
clc

Data = loadData('Tom');
Params = createParams();
visualizeTargetDigits(Data, Params)
Results = trainNetwork(Data, Params);
visualizeNetwork(Results.centers, 'trained network', 10);
Results = assignDigitsToPrototypes(Data, Results);
visualizeLabelProbabilityInNetwork(Results.labelCountInPrototypes, Data.targetdigits, 11)
visualizeNetwork(Results.estimatedDataOfPrototypes, 'labels in network', 12);
