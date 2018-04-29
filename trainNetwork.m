function Results = trainNetwork(Data, Params)

rng(Params.seed)
centers = rand(Params.sizeK^2,Params.dim)*Params.range;
iR=mod(randperm(Params.maxIter), size(Data.data, 1)+1); iR(iR==0) = 1;
updateSteps = zeros(1, Params.maxIter);
old_centers = centers;

switch Params.stoppingCriteria
    
    case 'maxIter'
        % stopping criteria = iteration
        
        for t=1:Params.maxIter
            i=iR(t);
            new_centers = som_step(old_centers, Data.data(i,:), Params.neighbor, Params.eta, Params.sigma);
            updateSteps(1,t) = getUpdateStep(new_centers, old_centers);
            old_centers = new_centers;
            
            if Params.displayTraining && (mod(t, Params.displayStep)==0 || t==1)
                visualizeTrainedNetwork(old_centers, ['network state at iteration: ', num2str(t)], 100)
            end
        end
        
    case 'tolUpdateStep'
        % stopping criteria = ||updateStep(t+1) - updateStep(t)|| > tolUpdateStep
        
        t = 1;
        updateStepMean = [];
        updateStepMeanDelta = [];
        continueTraining = true;
        
        while continueTraining
            
            i=iR(t);
            
            new_centers = som_step(old_centers, Data.data(i,:), Params.neighbor, Params.eta, Params.sigma);
            updateSteps(t) = getUpdateStep(new_centers, old_centers);
            old_centers = new_centers;
            
            if mod(t,Params.tolUpdateMeanWindow) == 0
                if t >= Params.tolUpdateMeanWindow
                    updateStepMean = [updateStepMean, mean(updateSteps(t-Params.tolUpdateMeanWindow+1:t)) ];
                end
                if t>= 2*Params.tolUpdateMeanWindow
                    updateStepMeanDelta = [updateStepMeanDelta, abs(updateStepMean(end) - updateStepMean(end-1))];
                end
            end

            if Params.displayTraining && (mod(t, Params.displayStep)==0 || t==1)
                visualizeTrainedNetwork(old_centers, ['network state at iteration: ', num2str(t)], 100)
                visualizeUpdateSteps(updateSteps, updateStepMean, updateStepMeanDelta, t, 101)
            end
            
            if t>= 2*Params.tolUpdateMeanWindow
                continueTraining =  (updateStepMeanDelta(end) > Params.tolUpdateStep && t<Params.maxIter);
            end
            
            t = t+1;
            
        end
        updateSteps = updateSteps(2:t);
        
end

% store
Results.centers = new_centers;
Results.updateSteps = updateSteps;

end

