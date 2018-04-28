function params = createParams()
%each neuron codes for a vector of size = dim values which represent an
%image in the data space (data space size = 255*dim)

params.sizeK=6; % set the size of the Kohonen map 
params.sigma=3; % set the width of the neighborhood via the width of the gaussian tha describes it
params.dim = 28*28; % dimension of the images
params.range = 255; % input range of the images ([0, 255])
params.neighbor = reshape(1:params.sizeK^2,params.sizeK,params.sizeK); % neighborhood matrix
params.eta = 0.01; %learning ratex
params.stoppingCriteria = 'tolUpdateStep';  %'tolUpdateStep', 'maIter'
params.maxIter = 15000; % maximum number of iteration
params.tolUpdateStep = 1; % threshold  
params.tolUpdateMeanWindow = 100; % iterations
params.displayTraining = true;
params.displayStep = 250; %round(params.maxIter/10);
params.seed = 1; % random seed 

end

