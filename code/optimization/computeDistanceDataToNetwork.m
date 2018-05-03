function sumOfDistances = computeDistanceDataToNetwork(data, network)

numberOfData = size(data,1);
sumOfDistances = 0;

for d=1:numberOfData
    digit = data(d,:);
    distanceDigitToNetwork =  assignOneDigitToAPrototype(digit, network);
    sumOfDistances = sumOfDistances + distanceDigitToNetwork; 
end

sumOfDistances = sumOfDistances/numberOfData;

end

