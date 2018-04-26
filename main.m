close all
clear variables
clc

Data = loadData('Zin�dine Zidane');
visualizeTargetDigits(Data)
Params = createParams();
Results = trainNetwork(Data, Params);
visualizeTrainedNetwork(Results.centers, Params);

