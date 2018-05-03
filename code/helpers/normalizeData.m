function data = normalizeData(data)

numberOfData = size(data,1);

for d=1:numberOfData
    maxOfDigit = max(data(d,:));
    minOfDigit = min(data(d,:));
    data(d,:) = (data(d,:) - minOfDigit)/(maxOfDigit - minOfDigit);
end

end

