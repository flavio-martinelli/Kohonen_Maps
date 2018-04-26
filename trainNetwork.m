function Results = trainNetwork(Data, Params)

centers = rand(Params.sizeK^2,Params.dim)*Params.range;

switch Params.stoppingCriteria
    
    case 'maxIter'
        % stopping criteria = iteration
        
        iR=mod(randperm(Params.maxIter), size(Data.data, 1)+1); iR(iR==0) = 1;
        costs = zeros(1, Params.maxIter);
        old_centers = centers;
        for t=1:Params.maxIter
            i=iR(t);
            new_centers = som_step(old_centers, Data.data(i,:), Params.neighbor, Params.eta, Params.sigma);
            costs(1,t) = getCost(new_centers, old_centers);
            old_centers = new_centers;
            if Params.displayTraining && (mod(t, Params.displayStep)==0 || t==1)
                visualizeTrainedNetwork(old_centers, ['network state at iteration: ', num2str(t)], 100)
            end
        end
        centers = new_centers;
        
    case 'tolCost'
        % stopping criteria = ||cost(t+1) - cost(t)|| > tolCost
        
        iR=mod(randperm(Params.maxIter), size(Data.data, 1)+1); iR(iR==0) = 1;
        costs = [1000];
        old_centers = centers;
        t = 1;
        costStep = Params.tolCost + 1;
        while costStep > Params.tolCost && t<Params.maxIter
            i=iR(t);
            new_centers = som_step(old_centers, Data.data(i,:), Params.neighbor, Params.eta, Params.sigma);
            costs = [costs, getCost(new_centers, old_centers)];
            old_centers = new_centers;
            if Params.displayTraining && (mod(t, Params.displayStep)==0 || t==1)
                visualizeTrainedNetwork(old_centers, ['network state at iteration: ', num2str(t)], 100)
            end
            costStep = abs(costs(end)-costs(end-1));
            t = t+1;
        end
        centers = new_centers;        
        
end

% store
Results.centers = centers;
Results.costs = costs;

% visualize
figure
plot(costs)
xlabel('iterations')
ylabel('cost function')
grid on

end

