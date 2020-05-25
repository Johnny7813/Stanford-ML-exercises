function [clusters, cluster] = updateVariables2(clusters, cluster, vertex, cNumber)

% update cluster and clusters
cluster  = [cluster, vertex];
cluster  = sort(cluster, 'descend');
clusters(vertex) = cNumber;

