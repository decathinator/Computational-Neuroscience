% Create a dataset where the agent responds randomly, 
% independent of feedback. You can create these data files using excel 
% and save as a .csv, or can generate them using Matlab. 
% Keep in mind that the task involves choosing between two options 
% (option 1 and option 2). Option 1 gives a reward ($1) on 70% of trials 
% and otherwise gives nothing ($0). Option 2 gives a reward ($1) 
% on 30% of trials and otherwise gives nothing ($0).

trialNumber = (1:200)';
optionChose = datasample(1:2, 200)';
rewardOutcomeDollars = zeros(200,1);

table1 = table(trialNumber,optionChose,rewardOutcomeDollars);

for i = 1:length(trialNumber)
    if table1.optionChose(i) == 1
        table1.rewardOutcomeDollars(i) = randsrc(1,1,[0,1;0.3,0.7]);
    elseif table1.optionChose(i) == 2
        table1.rewardOutcomeDollars(i) = randsrc(1,1,[0,1;0.7,0.3]);
    end
end

writetable(table1,'Zhuang_BIOL450_assignment1dataset.csv')
type 'Zhuang_BIOL450_assignment1dataset.csv'

