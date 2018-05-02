function params = createParams(sizeK, sigma, displayTraining)
%each neuron codes for a vector of size = dim values which represent an
%image in the data space (data space size = 255*dim)

params.sizeK=sizeK; % set the size of the Kohonen map 
params.sigma=sigma; % set the width of the neighborhood via the width of the gaussian tha describes it

params.maxIter = 1000; % maximum number of iteration
params.eta = 0.1; %learning ratex

params.dim = 28*28; % dimension of the images
params.range = 255; % input range of the images ([0, 255])
params.neighbor = reshape(1:params.sizeK^2,params.sizeK,params.sizeK); % neighborhood matrix

params.displayTraining = displayTraining;
params.displayStep = 500; %round(params.maxIter/10);
params.computeUdpates = true; % compute updates along training process
params.updateMeanWindow = 50; % iterations

params.seed = 1; % random seed 

end

