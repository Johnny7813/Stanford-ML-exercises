function [cluster, clusters, min_dist] = startCluster(Dist, clusters, cNumber)

m        = length(clusters);
[m,n]    = size(Dist);
min_dist = 1000;

index = sort(find(clusters==0));
l     = length(index);

for i=1:l,
    for j=1:(i-1),
        a = index(i);
        b = index(j);
        d = Dist(a,b);
        if d < min_dist,
            min_dist = d;
            cluster  = [a,b];
        end
    end
end

cluster  = sort(cluster, 'descend');
clusters(cluster) = cNumber;
