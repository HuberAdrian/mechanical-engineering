function [b] = myNewtonMatrix (x, y)
    m = length(x);
    n = length(y);
    X = zeros(n,n+1);
    b = zeros(m,1);
    if (m ~= n)
      disp('Wertepaare stimmen nicht überein') 
      return
    end
    
    for i=1:1:m
        X(i,1)= x(i);
        X(i,2)= y(i);
        if(i>1)
            j=3;
            while (j<i+2)
                X(i, j)= (X(i,j-1)-X(i-1, j-1))/(X(i,1)-X(i+2-j,1));
                j = j+1;
            end
           
        end
        b(i)= X(i, i+1);
    end
end