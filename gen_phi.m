%--------------------------------------------------------------------------
% Expand the basis matrix to a certain degree via tensor product
%--------------------------------------------------------------------------
% Input:  PHI_:---------------- matrix
%         degree:-------------- number
% Output: PHI:----------------- matrix
%--------------------------------------------------------------------------
function PHI = gen_phi(PHI_, degree)
    if degree == 1
        PHI = PHI_;
    else
        PHI = [];
        for k1 = 1:size(PHI_,2)
            A = gen_phi(PHI_(:,k1:end),degree-1);
            PHI = [PHI repmat(PHI_(:,k1),1,size(A,2)).*A];
        end
    end
