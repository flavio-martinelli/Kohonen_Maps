function Results = trainNetwork(Data, Params)

centers = rand(Params.sizeK^2,Params.dim)*Params.range;
iR=mod(randperm(Params.maxIter), size(Data.data, 1)+1); iR(iR==0) = 1;
costs = zeros(1, Params.maxIter);
old_centers = centers;

switch Params.stoppingCriteria
    
    case 'maxIter'
        % stopping criteria = iteration
        
        for t=1:Params.maxIter
            i=iR(t);
            new_centers = som_step(old_centers, Data.data(i,:), Params.neighbor, Params.eta, Params.sigma);
            costs(1,t) = getCost(new_centers, old_centers);
            old_centers = new_centers;
            
            if Params.displayTraining && (mod(t, Params.displayStep)==0 || t==1)
                visualizeTrainedNetwork(old_centers, ['network state at iteration: ', num2str(t)], 100)
            end
        end
        
    case 'tolCost'
        % stopping criteria = ||cost(t+1) - cost(t)|| > tolCost
        
        t = 1;
        costs(1,1) = inf;
        costStep = Params.tolCost + 1;
        while costStep > Params.tolCost && t<Params.maxIter
            i=iR(t);
            new_centers = som_step(old_centers, Data.data(i,:), Params.neighbor, Params.eta, Params.sigma);
            costs(1,t+1) = getCost(new_centers, old_centers);
            old_centers = new_centers;
            costStep = abs(costs(t+1)-costs(t));
            t = t+1;
            if Params.displayTraining && (mod(t, Params.displayStep)==0 || t==1)
                visualizeTrainedNetwork(old_centers, ['network state at iteration: ', num2str(t)], 100)
            end
            
        end
        costs = costs(find(costs)); costs = costs(2:end);
        
end

% store
Results.centers = new_centers;
Results.costs = costs;

% visualize
figure
plot(costs)
xlabel('iterations')
ylabel('cost function')
grid on

end

