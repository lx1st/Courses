function accuracy = ACU1(A,Y,L)
% numDigit: number of training samples of digit i
% numCorrect: number of correct predictions of A

accuracy = [];
X = Y;
for i = 1:size(X,2)
m = round(A*X{i});
p=m-L;
I=find(p==0);
acu = size(I,1)/size(L,1);
accuracy = [accuracy,acu];
end

