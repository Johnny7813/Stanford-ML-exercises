function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

p      = [0.01, 0.03];
params = [p, 10*p, 100*p, 1000*p];

% the result matrix has one row for each combination of sigma and C
% the values of sigma and C are in the first two columns. The third
% column holds the corresponding error value.
result = zeros(64,3); 

row   = 1;
for i = 1:8,
    for j = 1:8,
        C_test     = params(i);
        sigma_test = params(j);
    
        % provide gaussian Kernel with parameter sigma as a pointer
        gKernel = @(x,y) gaussianKernel(x,y, sigma_test);
        model   = svmTrain(X, y, C_test, gKernel, 1e-3, 5);
        pred    = svmPredict(model, Xval);
        
        % calculate the error
        correct = mean(double(pred == yval));
    
        result(row, :) = [C_test, sigma_test, correct];
        %fprintf('C = %f  ,  sigma = %f  ,  match = %f \n', C, sigma, correct);
        
        row += 1;
    end
end


[m , index] = max(result(:,3));
%fprintf('Best match value is %f at row index %i \n', m, index);

C = result(index, 1);
sigma = result(index, 2);
%fprintf('then C = %f   and   sigma = %f \n', C, sigma); 


% =========================================================================

end
