function [min_dist, vertex, Ind] = findMinDist(D, Ind, c)

rows     = size(D,1);
vertex   = 0;
min_dist = 1000;
len = length(c);
for i=1:len,
    last_col = c(i)-1;
    for j=1:last_col,
        if Ind(c(i),j) == 0,
            continue
        end
        dist = D(c(i),j);
        min_dist;
        
        if dist < min_dist,
            min_dist = dist;
            vertex   = j;
        end
    end
end


