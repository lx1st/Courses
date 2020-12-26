function [acuall6] = acu_sep(X,A_test,B_test,X_name)

acuall6 = [];

for  j = 1:length(X_name)
zed = 0;

zed = A_test*X{j};

[rows, columns] = size(zed);
for row = 1 : rows
  [maxValue, indexOfMax] = max(zed(row, :));
  zed(row, indexOfMax) = 1;
end

zed(zed<1) = 0;

check3 = 0;
ones3 = 0;

acu = [];
for i = 1:10
    
    check = zed(:,i) + B_test(:,i);
    
    check2 = sum(check(check==2))/2;
    check3 = check3 + check2;
    ones = B_test(:,i);
    ones2 = sum(ones);
    ones3 = ones3 + ones2;
    accuracy = check2/ones2;
    acu =[acu, accuracy];
end

acuall = check3/ones3;
acuall6 = [acuall6,acuall];

figure(1)
subplot(3,2,j),bar(acu);title(X_name(j),acuall6(j));

end 

