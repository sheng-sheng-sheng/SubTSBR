%--------------------------------------------------------------------------
% Before use: addpath('./RVM');
%--------------------------------------------------------------------------
% Threshold Sparse Bayesian Regression
% Find sparse weight, s.t. eta = PHI * weight
%--------------------------------------------------------------------------
% Input:  PHI:------------------------ matrix
%         eta:------------------------ column vector
%         threshold:------------------ number
% Output: weight:--------------------- column vector
%         standard_deviation:--------- column vector
%         model_selection_criterion:-- number
%--------------------------------------------------------------------------
function [weight, standard_deviation, model_selection_criterion] = TSBR(PHI, eta, threshold)
    [weight, standard_deviation, model_selection_criterion] = threshold_SparseBayes(PHI, eta, threshold);
    index_using = (weight~=0);
    if sum(index_using) > 0 && sum(~index_using) > 0
        [weight(index_using), standard_deviation(index_using), model_selection_criterion] = TSBR(PHI(:,index_using), eta, threshold);
    end

function [weight, standard_deviation, model_selection_criterion] = threshold_SparseBayes(PHI, eta, threshold)
    [PARAMETER,] = SparseBayes('Gaussian', PHI, eta);
    
    weight = zeros(size(PHI,2),1);
    variance = zeros(size(PHI,2),1);
    
    weight(PARAMETER.Relevant) = PARAMETER.Value;
    variance(PARAMETER.Relevant) = PARAMETER.Variance;
    model_selection_criterion = Inf;
    
    % abs(weight) greater than or equal to threshold will be used
    index_using = (abs(weight) >= threshold);
    weight(~index_using) = 0;
    variance(~index_using) = 0;
    if sum(index_using) > 0
        model_selection_criterion = sum(variance(index_using)./(weight(index_using).^2));
    end
    standard_deviation = variance.^0.5;
