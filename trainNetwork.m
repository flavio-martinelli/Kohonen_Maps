function Results = trainNetwork(Data, params)

centers = rand(params.sizeK^2,params.dim)*params.range;

switch params.stoppingCriteria
    
    case 'maxIter'
        % stopping criteria = iteration
        
        iR=mod(randperm(params.maxIter), size(Data.data, 1)+1); iR(iR==0) = 1;
        costs = zeros(1, params.maxIter);
        old_centers = centers;
        for t=1:params.maxIter
            i=iR(t);
            new_centers = som_step(old_centers,Data.data(i,:),params.neighbor, params.eta, params.sigma);
            costs(1,t) = getCost(new_centers, old_centers);
            old_centers = new_centers;
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

