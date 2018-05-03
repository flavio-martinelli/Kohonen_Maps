function Results = trainNetwork(data, Params)

iR=mod(randperm(Params.maxIter), size(data, 1)+1); iR(iR==0) = 1;
Results.updateSteps = zeros(1, Params.maxIter);
Results.updateStepMean = [];
Results.updateStepMeanDelta = [];
%rng(Params.seed);
Results.centers = rand(Params.sizeK^2,Params.dim)*Params.range;

% stopping criteria = iteration
for iter=1:Params.maxIter
    
    if Params.displayTraining && (mod(iter, round(Params.maxIter/5)) == 0 || iter == 1)
        disp(['iter: ', num2str(iter)])
    end
    
    i=iR(iter);
    new_centers = som_step(Results.centers, data(i,:), Params.neighbor, Params.eta, Params.sigma);
    
    if Params.computeUdpates
        Results = getUpdates(new_centers, Results, iter, Params);
    end
    
    if Params.displayTraining
        visualizeTrainingProcess(Results,  iter, Params, 101, 102)
    end
    
    Results.centers = new_centers;
end
end

