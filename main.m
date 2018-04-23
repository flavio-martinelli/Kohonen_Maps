close all
clear all
clc
%% Data extraction

data = dlmread('data.txt');     % read in data
labels = dlmread('labels.txt'); % read in labels

name = 'Flavio Martinelli';      
targetdigits = name2digits(name);   % assign the four digits that should be used

digitstoremove = setdiff(0:9,targetdigits);     % the other 6 digits are removed from the data set.
for i=1:6
    data(labels==digitstoremove(i),:) = [];
    labels(labels==digitstoremove(i)) = [];
end

dim = 28*28; % dimension of the images
range = 255; % input range of the images ([0, 255])
[dy, dx]=size(data);

%% Data visualization (can skip this part)

figure()

for i=1:4
    subplot(2,2,i);
    digits_i = data(labels==targetdigits(i),:);
    imagesc(reshape(digits_i(1,:),28,28)'); colormap gray;
    axis off
end

a = axes;
t = title(['Digits chosen for ', name]);
a.Visible = 'off';
t.Visible = 'on';

%% Network
clear digitstoremove digits_i  

% set the size of the Kohonen map. 
sizeK=6;

%set the width of the neighborhood via the width of the gaussian that
%describes it
sigma=3;

%each neuron codes for a vector of size = dim values which represent an
%image in the data space (data space size = 255*dim)

%initialise the centers randomly
centers = rand(sizeK^2,dim)*range;

% build a neighborhood matrix
neighbor = reshape(1:sizeK^2,sizeK,sizeK);

%learning rate
eta = 0.01; 
% maximal iteration count
tmax=5000; % this might or might not work; use your own convergence criterion

%set the random order in which the datapoints should be presented
iR=mod(randperm(tmax),dy)+1;

for t=1:tmax
    i=iR(t);
    centers=som_step(centers,data(i,:),neighbor,eta,sigma);
end