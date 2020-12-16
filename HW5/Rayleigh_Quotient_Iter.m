
function [eigenval,v] = Rayleigh_Quotient_Iter(A,v0)

m = size(A,1);
v = v0/norm(v0);
eigenval = v'*A*v;

for i = 1:10000
    w = (A - eigenval*eye(m))\v;
    v1 = v;
    v = w/norm(w);
    eigenval = v'*A*v;
    err = norm(v-v1);
    i = i+1;
    if err<1E-15,break;end
end

end