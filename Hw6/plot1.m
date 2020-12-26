function [] = plot1(y,x_name,A_test,b_test)

acu1 = ACU1(A_test,y,b_test);

for ii = 1:size(y,2)
    x = y{ii}
    x(x<10e-14)=nan;
    
    pic = reshape(x,28,28);
    
    figure(1); sgtitle('Structures for Collective 10 Digits by Methods' )
    subplot(3,2,ii);h=pcolor(pic);set(h, 'EdgeColor', 'none');colorbar;title(x_name(ii),acu1(ii));
    
    figure(2), sgtitle('Weights for Collective 10 Digits by Methods' )
    subplot(3,2,ii)
    bar(x),title(x_name(ii),acu1(ii));
    
end