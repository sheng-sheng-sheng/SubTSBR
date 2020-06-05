%--------------------------------------------------------------------------
% Expand the basis to a certain degree via tensor product
%--------------------------------------------------------------------------
% Input:  Basis_:-------------- row string array
%         degree:-------------- number
% Output: Basis:--------------- row string array
%--------------------------------------------------------------------------
function Basis = gen_basis(Basis_, degree)
    if degree == 1
        Basis = Basis_;
    else
        Basis = [];
        for k1 = 1:size(Basis_,2)
            A = gen_basis(Basis_(k1:end),degree-1);
            Basis = [Basis strcat(Basis_(k1),A)];
        end
    end
    