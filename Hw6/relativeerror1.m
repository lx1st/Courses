function [] = relativeerror1(A_train,x,B_train,x_name)

err = [];

for i = 1:length(x)
   b_eval=A_train*x{i};
   error=norm(abs(b_eval)-abs(B_train),2)/norm(B_train,2);
   err = [err,error];
figure(2)
bar(err);
xlabel('Method');
ylabel('Relative Error');
set(gca,'xticklabels',x_name)
sgtitle('Relative Error by Methods' )

end








