function [points,vals,usedPoints,dX] = runIsomap(data,threshold,maxDims,nearest)
%returns Isomap embedding for the matrix data
%
%
%   Inputs:
%       data -> d x N data matrix, where N > d.  If d > N, data will be transposed
%       threshold -> if nearest = true, the number of nearest neighbors to use,
%                       if nearest = false, the distance threshold to use
%       maxDims ->  The maximum number of dimensions to output (default = d)
%       nearest ->  Logical input.  True if using nearest neighbor threshold,
%                       false if using distance threshold.
%
%
%   Outputs:
%       embedded -> N x maxDims array of isomap-output points
%       vals -> The maxDims leading eigenvalues of the distortion matrix
%       usedPoints -> The points used in the calculation (in case there are
%                       multiple connected components
%       dX -> N x N sparse distance matrix on manifold



    if nargin < 4
        nearest = true;
    end
       
    readout = 200;
    s = size(data);
    if s(1) > s(2)
        data = data';
    end

    N = length(data(1,:));
    L = length(data(:,1));
    if nargin < 3 || isempty(maxDims) == 1
        maxDims = L;
    end
    
    if nearest
        maxNum = 2*N*threshold;
    else
        maxNum = N*200;
    end
        
    
    iValues = zeros(1,maxNum);
    jValues = zeros(1,maxNum);
    distanceValues = zeros(1,maxNum);
    
    fprintf(1,'Finding Distances\n');
    count = 0;
    for i=1:N
        
        if mod(i,readout) == 0
            fprintf(1,'Finding Distance for Point # %6i\n',i);
        end
        
        tempDists = find_distances(data(:,i),data);
                
        if ~nearest
            %compute cartesian distance matrix via distance threshold
            idx = find(tempDists < threshold);
               
        else
            %compute cartesian distance matrix by finding nearest neighbors
            [~,idx] = sort(tempDists);
            idx = idx(1:(threshold+1));
                        
        end
        
        vals = count + (1:2*length(idx));
        iValues(vals) = [i * ones(1,length(idx)), idx];
        jValues(vals) = [idx, i*ones(1,length(idx))];
        distanceValues(vals) = [tempDists(idx) tempDists(idx)];
              
        count = count + 2*length(idx);
        
    end
    
    iValues = iValues(1:count);
    jValues = jValues(1:count);
    distanceValues = distanceValues(1:count);
    
    
    fprintf(1,'Finding Largest Connected Component\n');
    dX = sparse(iValues,jValues,distanceValues,N,N);  
    [S,C] = graphconncomp(dX);
    f = 1:N;
    if S > 1
        vals = zeros(1,S);
        for i=1:S
            vals(i) = length(find(C==i));
        end
        [~,idx] = max(vals);
        f = find(C==idx(1));
        dX = dX(f,f);
    end
        
    fprintf(1,'Finding Manifold Matrix\n');
    D = graphallshortestpaths(dX);
    
    fprintf(1,'Finding Embedding\n');
    D = D .^ 2;
    M = -.5 .* (bsxfun(@minus, bsxfun(@minus, D, sum(D, 2) ./ N), sum(D, 1) ./ N) + sum(D(:)) ./ (N .^ 2));
    M(isnan(M)) = 0;
    M(isinf(M)) = 0;
    fprintf(1,'\tCalculating Eigenvalues\n');
    [vec, val] = eig(M);
    if size(vec, 2) < maxDims
        maxDims = size(vec, 2);
        warning(['Target dimensionality reduced to ' num2str(maxDims) '...']);
    end
	
    
    % Computing final embedding
    [val, ind] = sort(real(diag(val)), 'descend'); 
    vecs = vec(:,ind(1:maxDims));
    vals = val(1:maxDims);
    points = real(bsxfun(@times, vecs, sqrt(vals)'));
        
    usedPoints = f;
    
    
function    d = find_distances(x,y)
    
    d = bsxfun(@minus,y,x).^2;
    d = sqrt(sum(d));

    