function clusters = myClusteringAlgo3(X, boundry)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare

const         = boundry;
max_iter      = 100;
max_clusters  = 20;
cNumber       = 0 ;


% the columns of X are the points
% X = [1 1 2 3 3 3.5; 1 2 1 3 4 3.5];

[n, m] = size(X);

clusters = zeros(1,m);
Dist  = zeros(m,m);
Ind   = zeros(m,m);
nUsed = 0; 


% Initialisation of the distance matrix D
% and the Index matrix Ind
min_dist = 1000;
for i=1:m,
    for j=1:(i-1),
        Ind(i,j)  = 1;
        d         = norm(X(:,i)-X(:,j));
        Dist(i,j) = d;
    end
end

%cluster is a vector of indices for vectors that are in this cluster
%clusters is a vector like [0 1 2 0 0 1] showing to which cluster a
%vector i is belonging

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for k =1:max_clusters
    cNumber = cNumber + 1;
    [cluster, clusters, dist] = startCluster(Dist, clusters, cNumber);
    max_dist = dist;
    nUsed = nUsed + 2;
    for i=1:max_iter
        [dist, vertex] = findMinDist2(Dist, clusters, cluster, cNumber);
        if dist > const*max_dist
            break
        end
        nUsed = nUsed + 1;
        [clusters, cluster] = updateVariables2(clusters, cluster, vertex, cNumber);
        max_dist = max(max_dist, dist);
    end
    
    % we have classified all points
    if nUsed >= m
        break
    end
end



