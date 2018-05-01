function error = gerError(data, network)

error = 0;
numberOfData = size(data,1);

for d=1:numberOfData
    [distanceToPrototype, ~] = assignOneDigitToOnePrototype(data(d,:), network);
    error = error + distanceToPrototype;
end

end

