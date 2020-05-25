function [min_dist, vertex] = findMinDist2(Dist, clusters, cluster, cNumber)

rows     = size(Dist,1);
m        = length(cluster);
vertex   = -1;
min_dist = 1000;

nonMembers = find(clusters==0);
n          = length(nonMembers);
for i=1:m,
    a = cluster(i);
    for j=1:n,
        b = nonMembers(j);
        d = Dist(a,b);
        
        if d < min_dist,
            min_dist = d;
            vertex   = b;
        end
    end
end


