function plotEmbedding(data,points,dX)

    s = size(data);
    if s(1) < s(2)
        data = data';
    end
    
    s = size(points);
    if s(1) < s(2)
        points = points';
    end
    
    N = length(data(:,1));
    
    subplot(1,2,1)
    scatter3(data(:,1),data(:,2),data(:,3),[],1:N,'filled');
    if nargin == 3
        dX = triu(dX);
        [ii,jj] = find(dX > 0);
        hold on
        for i=1:length(ii)
            k = [ii(i) jj(i)];
            plot3(data(k,1),data(k,2),data(k,3),'k-')
        end
    end
    colormap parula
    axis equal off
    
    
    subplot(1,2,2)
    scatter(points(:,1),points(:,2),[],1:N,'filled');
    if nargin == 3
        hold on
        for i=1:length(ii)
            k = [ii(i) jj(i)];
            plot(points(k,1),points(k,2),'k-')
        end
    end
    colormap parula
    axis equal off
    