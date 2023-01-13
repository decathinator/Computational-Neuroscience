function fit = QlearningBasic(parm)
global lba uba lbt ubt
global data
global EVMatrix

% scales the parameters based on starting points provided
            a1=(uba-lba)/(1+exp(-parm(1)))+lba;
            t1=(ubt-lbt)/(1+exp(-parm(2)))+lbt;
    
% a1 is the alpha parameter from the Q-learning value function
% t1 is the temperature parameter from the softmax choice function 

nTrials = length(data);

trialfit = 1;
partialfit = 0;
fit=0;
% these are the expected values for each option

window1 = 0; % the Q value for option 1 on a given trial
window2 = 0; % the Q value for option 2 on a given trial
pr1 = 0;     % the probability of selecting option 1 on a given trial
pr2 = 0;     % the probability of selecting option 2 on a given trial

for trialnum = 1:length(data) 
    stimchoice = data(trialnum,2); % the choice made on a given trial
    r = data(trialnum,3); % the reward received on that trial
    
    pr1= exp(window1/t1)/(exp(window1/t1)+exp(window2/t1)); % softmax choice function for choosing option1 
    pr2= exp(window2/t1)/(exp(window1/t1)+exp(window2/t1)); % fill in for choosing option 2

    % inverse temp:
%     pr1= exp(window1*t1)/(exp(window1*t1)+exp(window2*t1)); % softmax choice function for choosing option1 
%     pr2= exp(window2*t1)/(exp(window1*t1)+exp(window2*t1)); % fill in for choosing option 2
   
   if stimchoice==1
      trialfit(trialnum) = pr1; 
      window1 = window1 + a1*(r-window1); %%%%%%%%update EV for option 1 
    elseif stimchoice==2
      trialfit(trialnum) = pr2;
      window2 = window2 + a1*(r-window2); %%%%%%%%update EV for option 2 
    end
  
  
   EVMatrix(trialnum,:)=[trialnum stimchoice window1 window2 pr1 pr2];
   partialfit=partialfit + log(trialfit(trialnum)); 
   fit = -1*partialfit; % negative log liklihood
      
end
end 



 % a1*(r-window1) is how Dr. Treadway did it


