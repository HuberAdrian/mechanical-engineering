function[]=mySimpsonregel(a,b,n)
 integral=0;
    h=(b-a)/n;

        for i=a:h:b-h
            integral=integral+((myIntfunction(i)+(4*myIntfunction(i+h/2))+myIntfunction(i+h))*(h/6));
        end
       fprintf('Die Fläche unter meiner Funktion von %2.3f bis %2.3f ist %2.3f\n',a,b,integral)
end