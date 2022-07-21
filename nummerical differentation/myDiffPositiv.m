function [y_diff] = myDiffPositiv (x, y)
    n =length(x);
    length_y=length(y);

    y_diff = 1:1:n;

    if (n==length_y)
        for i=1:1:n-1
            y_diff(i)=(y(i+1)-y(i))/(x(1+i)-x(i));
        end
       
    else 
        print('Länge der Werte stimmen nicht')
    end
end