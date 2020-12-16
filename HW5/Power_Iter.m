function [eigenval,eigenval_err] = Power_Iter(A,v0,D,max_iter)

eigenval_err = zeros(1,max_iter);

for i = 1:max_iter
 v0 = A*v0;
 v = v0/norm(v0);
eigenval = (v' * A * v)/(v' * v);
eigenval_err(i) = abs(eigenval - D(1,1)); 
end


