function [cluster, Ind] = updateVariables(cluster, Ind, vertex)


len = length(cluster)
for i=1:len,
    Ind(vertex,cluster(i)) = 0;
    Ind(cluster(i),vertex) = 0;
end

cluster  = [cluster, vertex];
cluster  = sort(cluster, 'descend');


