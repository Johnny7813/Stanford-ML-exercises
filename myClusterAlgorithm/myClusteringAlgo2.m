
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare

const = 1.1
max_iter = 100

% the columns of X are the points
X = [1 1 2 3 3 3.5; 1 2 1 3 4 3.5];

[n, m] = size(X);

custers = zeros(1,m);
D   = zeros(m,m);
Ind = zeros(m,m);


% Initialisation of the distance matrix D
% and the Index matrix Ind
min_dist = 1000;
for i=1:m,
    for j=1:(i-1),
        Ind(i,j) = 1;
        d        = norm(X(:,i)-X(:,j));
        D(i,j)   = d;
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dist = 0
max_dist


for i=1:max_iter
    [dist, vertex, Ind] = findMinDist(D, Ind, cluster);
    if dist > const*max_dist
        break
    end
    [cluster, Ind] = updateVariables(cluster, Ind, vertex);
    max_dist = max(max_dist, dist)
end

cluster

