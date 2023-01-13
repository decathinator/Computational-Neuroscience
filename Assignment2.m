%% Cathy Zhuang
% BIOL 450 Assignment 2
% 9 Feb 2022

%% Part 1
% 1.

STA_100 = calculateSpikeTriggeredAverage(H1_times, ...
    H1_stimulusData, H1_spikes(randperm(53601,100),1), 100);
STA_500 = calculateSpikeTriggeredAverage(H1_times, ...
    H1_stimulusData, H1_spikes(randperm(53601,500),1), 100);
STA_1k = calculateSpikeTriggeredAverage(H1_times, ...
    H1_stimulusData, H1_spikes(randperm(53601,1000),1), 100);
STA_5k = calculateSpikeTriggeredAverage(H1_times, ...
    H1_stimulusData, H1_spikes(randperm(53601,5000),1), 100);
STA_10k = calculateSpikeTriggeredAverage(H1_times, ...
    H1_stimulusData, H1_spikes(randperm(53601,10000),1), 100);
STA_25k = calculateSpikeTriggeredAverage(H1_times, ...
    H1_stimulusData, H1_spikes(randperm(53601,25000),1), 100);
STA_all = calculateSpikeTriggeredAverage(H1_times, ...
    H1_stimulusData, H1_spikes, 100);

    % p = randperm(n,k) returns a row vector containing k unique integers
    % selected randomly from 1 to n.

% 2. 
% What happens to the curve as N becomes larger? 
    % As N becomes larger, the amount of "noise" consistently decreases,
    % meaning there are less fluctuations as the number of spikes included
    % increases. In other words, the curve becomes smoother as N becomes
    % larger.

% 3. 

dk = [];

dk(1,1) = sqrt(sum((STA_100 - STA_all).^2));
dk(1,2) = sqrt(sum((STA_500 - STA_all).^2));
dk(1,3) = sqrt(sum((STA_1k - STA_all).^2));
dk(1,4) = sqrt(sum((STA_5k - STA_all).^2));
dk(1,5) = sqrt(sum((STA_10k - STA_all).^2));
dk(1,6) = sqrt(sum((STA_25k - STA_all).^2));
dk(1,7) = sqrt(sum((STA_all - STA_all).^2));

k = [100, 500, 1000, 5000, 10000, 25000, length(H1_spikes)];

hold off;
figure;
loglog(k, dk);
xlabel('N spikes')
ylabel('Average Changes')

% 4. 
% What is (roughly) the slope of the line
% you see? What does this say about how the accuracy of the measured STA
% improves as one watches the data for increasingly long periods of time?
    % The slope is roughly around -0.003, which means our estimate of b is
    % -0.003. The log of the errors is proportional to -0.003 times the log
    % of the N.
    % This means that as N increases, we will have better accuracy of
    % the measured STA.

%% Part 2


% 1. 

convolutionOutput = convolveDataWithSTA(H1_stimulusData,STA_all, 0.001);
plot(H1_times(1,1:1000), convolutionOutput(1:1000,1));
xlabel('Seconds')
ylabel('Convolution Score')

% 2. 
% What happens to the convolution function when a lot of
% spikes occur?

figure
plotSpikesOnData(H1_times,convolutionOutput,H1_spikes,0,1);

    % When the convolution is high, we also observe a larger number of 
    % spikes, meaning that higher convolution scores are associated with
    % more spikes. When the convolution score is low, we see less tendency
    % for spikes. This makes sense since the convolution score depends on
    % the stimulus data and spike triggered averages.

% 3. 
figure
histOutput = histogram(convolutionOutput, 20);
ylabel('Count')
xlabel('Convolution Score')

% 4. 

[binLocations,pSpike,numSpikes] = ...
    findSpikingProbabilitiesFromConvolution( ...
    convolutionOutput,H1_spikes,20);

% 5. 
% What does the curve on the right (p(spike|χ) vs. χ) look like? Does this
% agree with your intuition from the plot in question 2 of part II?
   
    % The curve looks like a logistic function S-shaped curve. This agrees
    % with out intuition from the previous plot because we expected these
    % sort of "binary" results; when the
    % convolution score was high, we saw spikes, and when the score was
    % low, we did not see spikes.

% 6. 
% Given a new stimulus presentation to the same neuron, describe how would
% you predict the location of spikes using the STA and the curve you
% derived in this homework set?

    % Use convolution scores to predict where the spikes occur, since we
    % have shown that convolution scores are related to spikes. When there
    % is a high convolution score, we can predict spikes, and when there is
    % a low convolution score, we can predict no spike.
