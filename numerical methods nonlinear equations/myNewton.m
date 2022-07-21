function [x_zero, res, n_iter] = myNewton (x0, tol, n_max) 
			x1 = 0;
            konv=100;
            n_iter=1;
            
            while (tol<konv && n_max>n_iter)
	            [f0, f1]=myFunction(x0);
                x1=x0-(f0/f1);
                %%disp(f0);
                %%disp(f1);
                n_iter= n_iter+1;
                disp(n_iter);
                konv=abs(x1-x0);
                x0=x1;
            end

            x_zero=x1;
            [f0]=myFunction(x_zero);
            res = f0;

end 