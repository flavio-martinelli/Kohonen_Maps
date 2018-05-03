function [distanceToAssignedProtoype, assignedPrototypeIndex] = assignOneDigitToAPrototype(digit, centers)

% network size
sizeK = sqrt(size(centers,1));

%find the best matching unit via the minimal distance to the datapoint
[distanceToAssignedProtoype, assignedPrototypeIndex]=min(sqrt(sum(abs(centers-repmat(digit,sizeK^2,1)).^2,2)));

end

