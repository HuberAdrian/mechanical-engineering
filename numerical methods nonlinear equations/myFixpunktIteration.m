function []=myFixpunktIteration(x0,tol)
x=myIntfunction(x0);
diff=abs(x-x0);
anfdiff=diff;
i=1;
    while diff>tol
        i=i+1;
        x0=x;
        x=myIntfunction(x0);
        diff=abs(x0-x);
        if diff>=anfdiff
            disp('Iterationsfunktion Konvergiert nicht, benutzen sie eine andere Iterationsfunktion');
            x='Abstoßender Fixpunkt';
            return;
        end
    end
    disp(i);
end
