function X = generateGaussianSwissRollDataSet(N)

    mu = [0 0;1 1;-1 -1; 1 -1;-1 1];
    sigma = repmat(eye(2)*.2,[1 1 5]);
    p = zeros(5,1) + 1/5;
    
    obj = gmdistribution(mu,sigma,p);
    
    X = pi*random(obj,N);
    X = X + min(X(:));
    
    [~,idx] = sort(X(:,1));
    X = X(idx,:);
    X = [X(:,1).*cos(X(:,1)) X(:,2) X(:,1).*sin(X(:,1))];