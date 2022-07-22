% Diese Funktion berechnet die right-hand side der Teilaufgabe 2.
function dq = rhs_Labor12(D,lambda,y0,a,v0ms,w,q,t)
    dq = [q(2,1);
            -2*D*w*q(2,1)-w^2*q(1,1)+w^2*y0*sin(2*pi*lambda*(v0ms*t+1/2*a*t^2))+2*D*w*2*pi*lambda*y0*(a*t+v0ms)*cos(2*pi*lambda*(v0ms*t+1/2*a*t^2))];
end