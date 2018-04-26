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
            
            if Params.displayTraining && mod(t, Params.displayStep)==0
                visualizeTrainedNetwork(new_centers, ['network state at iteration: ', num2str(t)], 100)
            end
        end
        centers = new_centers;
        
    case 'tolCost'
        % stopping criteria = ||cost(t+1) - cost(t)||
        
        
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

