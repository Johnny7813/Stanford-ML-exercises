
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare

const = 1.5

X = [1 1 2 3 3 3.5; 1 2 1 3 4 3.5];

[n, m] = size(X);

D   = zeros(6,6);
Ind = zeros(6,6);
cluster = -1;


% Initialisation of the distance matrix D
% and the Index matrix Ind
min_dist = D(2,1);
for i=1:m,
    for j=1:(i-1),
        Ind(i,j) = 1;
        d        = norm(X(:,i)-X(:,j));
        D(i,j)   = d;
        % find min distance and first two points
        % of the vertex
        if d < min_dist,
            min_dist = d;
            cluster  = [i,j];
        end
    end
end

Ind(cluster(1), cluster(2)) = 0;
max_dist = min_dist;

Ind
D
cluster


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dist = 0;

while dist < const*max_dist,

    [dist, vertex, Ind] = findMinDist(D, Ind, cluster);
    cluster  = [cluster, vertex];
    cluster  = sort(cluster, 'descend');
    max_dist = max(max_dist, dist);
end

Ind
dist
cluster

