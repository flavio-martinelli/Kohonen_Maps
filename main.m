close all
clear variables
clc

Data = loadData('Flavio');
visualizeTargetDigits(Data)
Params = createParams();
Results = trainNetwork(Data, Params);
visualizeTrainedNetwork(Results.centers, 'trained network', 1);

