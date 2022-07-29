function [y_diff] = myDiffNegativ (x, y)
    n =length(x);
    length_y=length(y);

    y_diff = 1:1:n;

    if (n==length_y)
        for i=2:1:n-1
            y_diff(i)=(y(i)-y(i-1))/(x(i)-x(i-1));
        end
       
    else 
        print('Länge der Werte stimmen nicht')
    end
end