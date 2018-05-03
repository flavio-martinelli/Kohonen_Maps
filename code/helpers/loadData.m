function Data = loadData(name)

% load
data = dlmread('data.txt');    
labels = dlmread('labels.txt');

% target and trash digits
targetdigits = name2digits(name); % assign the four digits that should be used
digitstoremove = setdiff(0:9,targetdigits); % the other 6 digits are removed from the data set.
for i=1:6
    data(labels==digitstoremove(i),:) = [];
    labels(labels==digitstoremove(i)) = [];
end

% store
Data.data = data;
Data.labels = labels;
Data.name = name;
Data.targetdigits = targetdigits;
Data.digitstoremove = digitstoremove;
Data.labelSet = unique(labels);

end

