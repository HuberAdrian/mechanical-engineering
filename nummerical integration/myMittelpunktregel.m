function[]=myMittelpunktregel(a,b,n)
integral=0;
h=(b-a)/n;
fileID=fopen('Mittelpunktregel.txt', 'w');
    if (fileID==-1)
    disp('Error opening Mittelpunktregel.dat');
    else
        for i=a:h:b-h
        integral=integral+myIntfunction(i+h/2)*h;
        end
    fprintf('Die Fäche unter unserer Funktion von %2.3f bis %2.3f ist %2.3f \n',a,b,integral)
    fprintf(fileID,'Die Fläche unter meiner Funktion ist %2.3f \n',integral)
    fprintf(fileID,'Die Fäche unter unserer Funktion von %2.3f bis %2.3f ist %2.3f \n',a,b,integral)
    end
fclose(fileID);
end