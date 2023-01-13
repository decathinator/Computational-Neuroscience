% % create matrices with memories M = 1, 2, ..., 199, 200
% N = cell(200,1)
% for k = 1:200 
%     N{k} = zeros(k,50)
% end
% 
% for k = 1:200                     
%     for i=1:k
%        for j = 1:50
%            N{k}(i,j)= randsample(pop, 1);
%        end
%     end
% end
% 
% % created weighted matrices from all the matrices
% weighted3 = cell(200,1)            
% for i = 1:200
%     weighted3{i} = Training(N{i})
% end
% 
% % create initial condition
% % the first row of our memory matrix will be the initial condition, with
% % some values changed
% loc = randperm(50, 10);                     % 10 random column locations chosen to alter the existing memory
% N2 = N
% for j = 1:200
%     for i = 1:length(loc)
%         N2{j}(1, loc) = randsample(pop, 1); % Random generation of -1 or 1 in that position
%     end
% end
% 
% final2 = cell(200,1)
% for i = 1:200
%     final2{i} = Recall(weighted3{i}, N{i}(1,:), 1)
% end
% 
% % see if our final output matches the memory
% truevalues = cell(200,1)
% for i = 1:200
%     truevalues{i} = final2{i}(1,:) == N{i}(1,:)
% end
%   
% % find proportion of the output that matches our memory
% proportion_true = zeros(200,1)
% for i = 1:200
%     proportion_true(i) = sum(truevalues{i})/50
% end
% 
% % plot proportions
% plot(proportion_true)








pop = [-1 1];                       % we will generate a 3x50 matrix with 
                                    % values of -1 and 1 picked randomly

M = zeros(3,50); 
for i=1:3
    for j = 1:50
        M(i,j)= randsample(pop, 1)
    end
end

weighted = Training(M)             % train the network on three memories
M2 = M;                             % duplicate the matrix and change some values
M2(1, 2) = 1;
M2(1, 3) = -1;  
M2(1, 45) = 1;

si = M2(1, :);                      % set initial condition from the changed matrix
T = 1;                              % set iterations to 1 iteration
final = Recall(weighted, si, T)    % run


isequal(M(1,:), final)            % check equality