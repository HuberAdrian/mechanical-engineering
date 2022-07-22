function [y0] = myStueckweiseInterpolation (x, y, x0)
    m = length(x);
    n = length(y);
    if (m == n)
    j = 0;
        for (i=1:1:m)
           if (x(i) < x0 && x(i+1) >x0)
                j = i;
           end
        end 
       y0 = y(j) + (x0-x(j))*(y(j+1)-y(j))/(x(j+1)-x(j));
        plot()
        else 
        disp('Wertepaare stimmen nicht überein')  
        end
end