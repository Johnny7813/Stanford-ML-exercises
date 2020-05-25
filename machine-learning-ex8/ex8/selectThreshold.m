function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

% m length of pval vector (column vector)
m = size(pval,1);       

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

    ytest = zeros(m,1);
    ytest(pval < epsilon) = 1;
    
    tp = sum(ytest & yval); % true positives
    fp = sum(ytest & (!yval)); % false positives
    fn = sum((!ytest) & yval); % false negatives
    
    all_pos_predictions = tp+fp;
    all_really_pos      = tp+fn;
    if (all_pos_predictions) == 0
        continue
    end
    
    prec = tp/(all_pos_predictions);
    rec  = tp/(all_really_pos);
    F1   = 2*prec*rec/(prec+rec);








    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
