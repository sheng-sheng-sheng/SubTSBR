%--------------------------------------------------------------------------
% Print the result
%--------------------------------------------------------------------------
% Input:  Basis:---------------------- row string array
%         weight:--------------------- column vector
%         standard_deviation:--------- column vector
%         model_selection_criterion:-- number
% Output: out:------------------------ string
%--------------------------------------------------------------------------
function out = output(Basis, weight, standard_deviation, model_selection_criterion)
    out = [];
    if exist('standard_deviation') && exist('model_selection_criterion')
        for k1 = 1:size(weight,1)
            if weight(k1) ~= 0
                out = [out, sprintf('%.3f(%.3f)  %s\n', weight(k1), standard_deviation(k1), Basis(k1))];
            end
        end
        out = [out, sprintf('Model selection criterion = %.3f * 0.001\n', 1000 * model_selection_criterion)];
    else
        for k1 = 1:size(weight,1)
            if weight(k1) ~= 0
                out = [out, sprintf('%.3f %s\n', weight(k1), Basis(k1))];
            end
        end
    end
    