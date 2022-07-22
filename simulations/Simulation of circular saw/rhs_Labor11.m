function dphi = rhs_Labor11(D,w,M,phi,Js)
    dphi = [phi(2,1);
            -2*D*w*phi(2,1)-w^2*phi(1,1)+M/Js];
end