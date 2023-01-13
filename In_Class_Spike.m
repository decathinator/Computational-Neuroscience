cd('C:\Users\Cathy\Documents\MATLAB'); 
% 2
[times,spikes] = generateSpikingData_poisson(10,10);

% 3
plotSpikeTrain(times,spikes); % Don't really see any pattern

% 5
% .01, .05, .1, .25, and 1 for window sizes
plotAllWindowTypes(times,spikes, 0.01);
plotAllWindowTypes(times,spikes, 0.05);
plotAllWindowTypes(times,spikes, 0.1);
plotAllWindowTypes(times,spikes, 0.25);
plotAllWindowTypes(times,spikes, 1);
% The oscillations are wider (over time) and smoother since we 
% bin them larger


% 6.
% Repeat steps 2) to 5), but now start with generating an oscillatory time
% series using generateSpikingData_oscillations(max_rate,min_rate,frequency).
% This process is called an “inhomogeneous Poisson process” because it
% represents a Poisson process whose mean changes with time. You can
% the default settings except that you should have the maximum firing rate
% be 200, the minimum firing rate be 100, and the frequency should be 1.
[times1, spikes1] = generateSpikingData_oscillations(200,100,1);
plotSpikeTrain(times1,spikes1); 

plotAllWindowTypes(times1,spikes1, 0.01);
plotAllWindowTypes(times1,spikes1, 0.05);
plotAllWindowTypes(times1,spikes1, 0.1);
plotAllWindowTypes(times1,spikes1, 0.25);
plotAllWindowTypes(times1,spikes1, 1);

% 7.
% For the four plot types, which looks most accurate at each of the time bin
% sizes? Why might this be?
% Causal is more consistent across different time bins since it mainly
% focuses on future neural activity as opposed to previous stimuli
% Additionally, gaussian can be a little too smooth at larger time bins
% because it does not count things at the edge of the distribution

% 8) Let’s look explicitly at the difference between gaussian-windowed firing
% rates and causally-windowed rates. Use
% calculateGaussianWindowedFiringRates(times,spikes,sigma) and
% calculateCausalFilteredFiringRates(times,spikes,alpha) to generate
% filtered plots for sigma = 0.05 (and alpha = 1/0.05). Plot the resulting firing
% rate plots on the same axes. What is the difference between the two
% plots?

calculateGaussianWindowedFiringRates(times1,spikes1, 0.05);
hold on
calculateCausalFilteredFiringRates(times1,spikes1, 1/0.05);
hold off

% Gaussian comes after causal since causal does not look at the future

%% Tuning Curve, HELP!!!
% Use linspace(min,max,N) to create a set of 100 evenly-space angles
% between 0 and 2p.
angles = linspace(0,2*pi,100);

% For each of the angles, use generateSpikingData_angles.m to calculate
% an average firing rate (you can use the default parameters)

for i = 1:length(angles)
    [times2, spikes2] = generateSpikingData_angle(angles(:,i),[],[]);
end
% rates(i,,:) = calculateFiringRates(times2,spikes2,[]);
%[binTimes1,rates1] = calculateFiringRates(times2,spikes2,[]);

% 3) Plot the observed tuning curve. What is the preferred angle?

%% H1 stuffs

% Load the data set in H1_data.mat into your workspace. This data set 
% provides the spike times of the fruit fly H1 neuron (H1_spikes) when 
% presented with a stimulus (H1_stimulusData). H1_times are the times 
% associated with the stimulus values.

% 2) Use the function calculateSpikeTriggeredAverage.m to calculate and plot
% the Spike Triggered Average (STA) for the data using only the first 100 
% spike times and an averagingWindow of 100.
STA = calculateSpikeTriggeredAverage(H1_times, H1_stimulusData, H1_spikes(100,1), 100);

% 3) Now do the same for the first 50, 100, 1000, and 10000, and all spikes
% (note that this last one may take a minute to run). How does the curve 
% change as you increase the amount of data? Do the changes look 
% random or systematic (i.e., do the curves consistently increase or decreae 
% with the number of spikes included, or do they flucate above and below 
% the large-number-of-spikes solution)?
STA = calculateSpikeTriggeredAverage(H1_times, H1_stimulusData, H1_spikes(50,1), 100);
STA = calculateSpikeTriggeredAverage(H1_times, H1_stimulusData, H1_spikes(100,1), 100);
STA = calculateSpikeTriggeredAverage(H1_times, H1_stimulusData, H1_spikes(1000,1), 100);
STA = calculateSpikeTriggeredAverage(H1_times, H1_stimulusData, H1_spikes(10000,1), 100);
STA = calculateSpikeTriggeredAverage(H1_times, H1_stimulusData, H1_spikes, 100);

% curve changes seem pretty random to me, but the last one does not seem
% random?

% 4) Calculate the Coefficient of Variation (CV) and for the inter-spike intervals 
% this data set. Does it look more ordered, random, bursting, or somewhere 
% in between?
for i = 1:length(H1_spikes)-1
    ISI(1,i) = diff([H1_spikes(i), H1_spikes(i+1)]);
end
CV = mean(ISI)/std(ISI);

% since CV is pretty much 0.5, it's right in between random vs ordered
