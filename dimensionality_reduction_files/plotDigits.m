function plotDigits(data,numToPlot)
%plots hand-written digits (or decompositions of them) from the MNIST
%collection
%
%Inputs:
%   data -> N x d array containing N images each containing d pixels
%   numToPlot -> Either a number of digits to plot (it will take the first
%                   'numToPlot' rows of 'data') or a list of indices to
%                   plot.  If left blank the first min(N,25) images will be
%                   plotted.
%
%   Example usages:
%       plotDigits(data,25) -> plots images from the first 25 rows of data
%       idx = randi(1000,[25 1]);plotDigits(data,idx) -> plots 25 random rows
%       plotDigits(data) -> plots the first 25 

    s = size(data);
    if nargin < 2 || isempty(numToPlot)
        numToPlot = min(s(1),25);
    end
    
    
    if length(numToPlot) == 1
        idx = 1:numToPlot;
        N = numToPlot;
    else
        idx = numToPlot;
        N = length(idx);
    end
    

    L = min(N,5);
    M = ceil(N/L);

    load('saved_colormaps.mat','cc','cc2')
    imageLength = round(sqrt(length(data(1,:))));
    data = data(idx,:);
    a = max(abs(data(:)));
    b = min(data(:));
    figure
    for i=1:N
        subplot(M,L,i)
        idx(i);
        imagesc(reshape(data(i,:),[imageLength imageLength])')
        axis equal tight off
        if b > -1e-10
            caxis([0 .9*a]);
            colormap(cc)
        else
            caxis([-a a])
            colormap(cc2)
        end
    end
        