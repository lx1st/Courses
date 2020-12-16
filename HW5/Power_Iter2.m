function [eigenval,v] = Power_Iter2(A,v0,max_iter)



for i = 1:max_iter
 v0 = A*v0;
 v = v0/norm(v0);
eigenval = (v' * A * v)/(v' * v);

end
