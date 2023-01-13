function X = generateSwissRollDataSet(N)
%generates an Nx3 swiss roll data set

    X = 1.5*2*pi*rand([N,2]);
    [~,idx] = sort(X);
    X = X(idx(:,1),:);
    X = bsxfun(@plus,[X(:,1).*cos(X(:,1)) X(:,2) X(:,1).*sin(X(:,1))],[10 0 5]);
    
    
    