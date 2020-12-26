function XXX = filter_X(y)
XXX = {};
for i = 1:length(y)
    X = y{i};

% X(X<10e-14)=0;
[row,col,I] = find(X(:));
sorts = sort(I,'descend');
n = size(sorts,1);
m = round(n/2);
X(X<sorts(m))=0;
XX=X;
XXX{i} = XX;
end 

