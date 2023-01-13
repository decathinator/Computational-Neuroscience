%March 27 2017 
%Code to get basic RL model parameters from 2-armed bandit.
%Treadlab @ Emory 


clear
clear global

%UPDATE YOUR PATHS
% cd('~/Desktop'); %cd to wherever you saved the scripts 
% dataDirectory = '~/Desktop';  
% outputDirectory = '~/Desktop';
% modelDir = cd(dataDirectory);

dataDirectory = pwd;
outputDirectory = pwd;
modelDir = pwd;

filenames_all = {'SampleData1'}; 
cd(modelDir);
global lba uba lbt ubt
global EVMatrix

subdone=0;

for subnum = 1:length(filenames_all)
    
    fname = filenames_all{subnum};
    modelDir = cd(dataDirectory);
    rawData = dlmread([fname],',');  %read in the data... 
    cd(modelDir);
    
    global data
    data = rawData; 
    nTrials = length(data); 
    
numparams=2;
numstarts=50;

%sets your upper and lower bounds for each parameter.
lba=0; uba=1;
lbt=0; ubt=30;

numfits=0;
bestfit=10000;

% will fit the model once for each parameter combination
for i=1:numstarts
          RandVeca=randi(1000);
          RandVect=randi(1000);
          RandomStarta = ((RandVeca(1)/1000)-.5)*10;
          RandomStartt = ((RandVect(1)/1000)-.5)*10;
          parm=[RandomStarta RandomStartt];  
             [parm, fit]=fminsearch('QlearningBasic',parm);
             numfits=numfits+1; 
            a1=(uba-lba)/(1+exp(-parm(1)))+lba;
            t1=(ubt-lbt)/(1+exp(-parm(2)))+lbt;
           
        %takes the best fitting parameters if the fit is the best fit so far
        if fit<=bestfit
            bestfit=fit;
            besta1=a1;
            bestt1=t1;
  
        end 
        
    end
   
a1=besta1;
t1=bestt1;
fit=bestfit;

        
        xlsOutGLCSO = [a1; t1; fit]  % the alpha and temperature parameters that best fit for the subj, along with the log likelihood (fit) 
        subdone=subdone+1

        clear output
     
        outputMatrix = [xlsOutGLCSO]
        disp('done with this subject!');    
        allOutputMatrix(subdone,:) = outputMatrix; 
       
    modelDir = cd(outputDirectory);
    cd(modelDir);
        
end
    %saves it at the end so you have one file with each row being the
    %output for 1 subjects
    eval(['save ' fname '_QlearningBasic.txt allOutputMatrix -ascii']);
     
    
    
