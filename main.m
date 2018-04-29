close all
clear variables
clc

Data = loadData('Tom');
visualizeTargetDigits(Data)
Params = createParams();
Results = trainNetwork(Data, Params);
visualizeNetwork(Results.centers, 'trained network', 10);
Results = assignDigitsToPrototypes(Data, Results);
visualizeNetwork(Results.estimatedDataOfPrototypes, 'labels in network', 11);
