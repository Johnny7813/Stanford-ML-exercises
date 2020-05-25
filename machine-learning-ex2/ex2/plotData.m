function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%


ind0 = find(y==0);
ind1 = find(y==1);
x1   = X(:,1);
x2   = X(:,2);
x1o  = x1(ind0);
x1x  = x1(ind1);
x2o  = x2(ind0);
x2x  = x2(ind1);


plot(x1o, x2o, 'ko');
hold on;
plot(x1x, x2x, 'r+');






% =========================================================================



hold off;

end
