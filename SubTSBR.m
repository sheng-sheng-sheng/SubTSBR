%--------------------------------------------------------------------------
% Before use: addpath('./RVM');
%--------------------------------------------------------------------------
% Threshold Sparse Bayesian Regression with subsampling
% Find sparse weight, s.t. eta = PHI * weight
%--------------------------------------------------------------------------
% Input:  PHI:--------------------------- matrix
%         eta:--------------------------- column vector
%         threshold:--------------------- number
%         S (subsampling size):---------- number
%         L (the number of subsamples):-- number
% Output: weight:------------------------ column vector
%         standard_deviation:------------ column vector
%         model_selection_criterion:----- number
%--------------------------------------------------------------------------
function [weight, standard_deviation, model_selection_criterion, points_chosen] = SubTSBR(PHI, eta, threshold, S, L)    
    W_ = zeros(size(PHI,2), L);    % One column for each regression
    SD_ = zeros(size(PHI,2), L);
    MSC_ = zeros(1, L);
    PC_ = zeros(S, L);
    for k1 = 1:L
        PC_(:,k1) = randperm(size(PHI,1), S);
        [W_(:,k1), SD_(:,k1), MSC_(k1)] = TSBR(PHI(PC_(:,k1),:), eta(PC_(:,k1)), threshold);
    end
    [~,I] = min(MSC_);
    weight = W_(:,I);
    standard_deviation = SD_(:,I);
    model_selection_criterion = MSC_(I);
    points_chosen = PC_(:,I);
