close all
clear variables
clc

Data = loadData('Zinédine Zidane');
visualizeTargetDigits(Data)
Params = createParams();
Results = trainNetwork(Data, Params);
visualizeTrainedNetwork(Results.centers, Params);

