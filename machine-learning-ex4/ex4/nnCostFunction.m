function [J grad] = nnCostFunction(nn_params, input_layer_size, ...
                                   hidden_layer_size, num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% m is the number of rows of X, see above
A1   =  [ones(m,1)  X]' ;
A2s  =  sigmoid(Theta1*A1) ;
A2   =  [ones(1, size(A2s,2)) ; A2s] ;
A3   =  sigmoid(Theta2*A2) ;

% Y1 matrix has in its columns y  and  Y2 has in its columns (1-y)
Y1   =  zeros(size(A3)) ;
Y2   =  ones(size(A3)) ;



%Assemble the y-matrix, each column is num_labels and has only one 1
%the rest is zeros; this is a vectorised form
ind = (0:num_labels:(m-1)*(num_labels))'+y;
ys  = zeros(m*num_labels,1);
ys(ind) = 1;
% Y1 has the y vectors as columns
% Y1 has the 1-y vectors as columns
Y1  = reshape(ys, num_labels, m);
Y2  = 1 - Y1;





% sum over the log of h_theta
T  = Y1.*log(A3) + Y2.*log(1-A3);
J1 = -1/m * sum(sum(T)) ;

% regulation term, here we do not include the first term
Theta1s = Theta1(:, 2:end) ;
Theta2s = Theta2(:, 2:end) ;
J2 = lambda/(2*m) * (sum(sum(Theta1s.^2)) + sum(sum(Theta2s.^2))) ;

% adding both terms gives J
J  = J1 + J2 ;


%%% Backpropagation: Calculation of gradients
Delta1 = zeros(hidden_layer_size, input_layer_size+1);
Delta2 = zeros(num_labels, hidden_layer_size+1);


%vectorised Backpropagation
delta3 = A3 - Y1;
delta2 = Theta2'*delta3 .* A2 .* (1-A2) ;
delta2 = delta2(2:end, :) ;
Delta1 = delta2*A1' ;
Delta2 = delta3*A2' ;


% Theta matrices with the bias column set to 0
Theta1o = [zeros(size(Theta1s,1),1) , Theta1s];
Theta2o = [zeros(size(Theta2s,1),1) , Theta2s];


Theta1_grad  = 1/m*Delta1 + lambda/m*Theta1o;
Theta2_grad  = 1/m*Delta2 + lambda/m*Theta2o;


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
