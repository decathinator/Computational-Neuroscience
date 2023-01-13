
function[miValue] = Assignment3_calculateMI_function(timeBin)

    load('Data_neuron2.mat');

% Make a vector of spike "words" - the total number of spikes in each 1 ms pre-motor window
for iTrial = 1:length(spikes)
    word = spikes(iTrial,1:end);
    
    % Segment data into bin.
    % Note- the second argument of the function histcounts dictates the
    % edges of the bins.
    edges = [-40:timeBin:0];
    [N, edges] = histcounts(word, edges);
    
    words(iTrial, :) = N;
    
end

% Separate pitch into two bins
% First find median pitch
medianPitch = median(pitches);

% Make an empty vector to hold the binned pitch values
pitchValue = nan(length(pitches),1);

% Go through all the pitch values and put them into low or high groups
for iPitch = 1:length(pitches)
    
    % YOUR TURN: Set below-median pitch to be designated as 0
    % Note, here you should be modifying the variable pitchValue(iPitch,1)

    if pitches(iPitch) < medianPitch
        pitchValue(iPitch, 1) = 0;
    
    % YOUR TURN: Set above-median pitch to be designated as 1
    % Note, here you should be modifying the variable pitchValue(iPitch,1),
    % but you should never modify it above and here for the same iPitch.

    else
        pitchValue(iPitch, 1) = 1;

    end
    
end

%Make sure you have each of the variables listed below defined
clearvars -except words pitchValue spikes pitches timeBins miValues N

%Now we have all the binned words that we will used to find MI

% Remember that I(X;Y) = H(X) - H(X|Y).

% First we will find H(X), or H(spikes).
% H(X) = - Sum(plogp).
% Find the probability of each different spike word.

%Find the all the different unique words
%uniqueWords = unique(words,'rows');
uniqueWords = unique(words, 'rows');

% YOUR TURN: Make an empty vector for probabilities that is the length of the number
% of unique words
pSpikes = nan(length(uniqueWords),1);

% YOUR TURN: Find the total number of words.
totalWords = length(words);

% YOUR TURN: Go through each different word
for iWord = 1:length(uniqueWords)
    
    % Set the word of interest
    word = uniqueWords(iWord, :);
    
    % YOUR TURN: Find the total number of that word in all the trials
    % ---- note- the function ismember(...) might be useful to you.
    % ---- type doc ismember in the workspace to see how to use it.
    numWord = sum(ismember(words, word, 'rows'));
    
    % Divide by the total number of words to find the probability.
    pSpikes(iWord) = numWord/totalWords;
end


% YOUR TURN: Now we have to find the total entropy of spike words

spikeEntropy = sum(-pSpikes.*log2(pSpikes));

% Make sure you have all the variables listed below defined.
clearvars -except spikeEntropy pitchValue words spikes pitches timeBins miValues N

% We need to split the spiking data into two groups based on the pitch
% group. We need to keep track of the pitch group and the probability of
% the data falling into each pitch group.

% YOUR TURN: Identify the unique pitch values (0 or 1)
pitchGroups = unique(pitchValue);

% YOUR TURN: Make an empty vector to store the probabilities of the pitch values.
pPitch = nan(size(pitchGroups));

% Make an empty vector to store the conditional entropies for each pitch
spikeEntropy_pitch = nan(size(pitchGroups));

% Find the total number of different pitch values
totalPitches = size(pitchValue,1);

% Go through each pitch group, identify spike words that correspond to that
% group, find the conditional entropy of the spiking for that pitch.

for iPitch = 1:size(pitchGroups,1)
    
    % Find the pitch value for this group, 0 or 1 
    pitch = pitchGroups(iPitch,:);
    
    % YOUR TURN: Identify the trial numbers with this pitch value of 0 or 1
    pitchIndices = find(pitchValue==pitch);
    
    % YOUR TURN: Find the total number of trials with this pitch value of 0
    % or 1
    numPitch = length(pitchIndices);
    
    % YOUR TURN: Find the probability of this pitch
    pPitch(iPitch,1) = numPitch/totalPitches;
    
    % Get the spike words for these trial numbers
    words_pitch = words(pitchIndices,:);
    
    % Find the entropy of the spike words associated with this pitch value
    % The following code should be very similar to the code above.
    
    %YOUR TURN: Find the all the different unique words
    uniqueWords_pitch = unique(words_pitch, 'rows');
    
    % Make an empty vector for probabilities that is the length of the number
    % of unique words
    pSpikes_pitch = nan(length(uniqueWords_pitch), 1);
    
    % Find the total number of words.
    totalWords_pitch = size(words_pitch,1);
    
    % Go through each different word
    for iWord_pitch = 1:length(uniqueWords_pitch)
        
        % Set the word of interest
        word_pitch = uniqueWords_pitch(iWord_pitch,:);
        
        % YOUR TURN: Find the total number of that word in all the trials
        numWord_pitch = sum(ismember(words_pitch, word_pitch, 'rows'));
        
        % YOUR TURN: Find the conditional probability
        pSpikes_pitch(iWord_pitch) = numWord_pitch/totalWords_pitch;

    end
    
    %YOUR TURN: Find the entropy of spiking conditioned on each pitch value

    spikeEntropy_pitch(iPitch) = sum(-pSpikes_pitch.*log2(pSpikes_pitch))

    
end

% The conditional entropy is just the weighted sum of the spike entropies
% for each pitch value.

spikeGivenPitchEntropy = sum(pPitch.*spikeEntropy_pitch);

clearvars -except spikeEntropy spikeGivenPitchEntropy pitchValue words spikes pitches timeBins miValues N

miValue = spikeEntropy - spikeGivenPitchEntropy;
