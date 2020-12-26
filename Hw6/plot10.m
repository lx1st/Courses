function [] = plot10(y,X_name,A_test,b_test)

for jj = 1:length(y)

   X = y{jj};



for ii = 1:size(X,2)
    x = X(:,ii);
    x(x<10e-14)=nan;
    acu1 = ACU11(A_test,x,b_test);
    pic = reshape(x,28,28);
    
    figure(jj); sgtitle(sprintf('Structures for 10 Digits by %s',X_name{jj}))
    subplot(2,5,ii);h=pcolor(pic);set(h, 'EdgeColor', 'none'); 
    figure(jj+6), sgtitle(sprintf('Weights for 10 Digits by%s',X_name{jj}));
    subplot(2,5,ii)
    bar(x),title(ii);
    
end

end