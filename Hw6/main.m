clear; close all; clc
load('data01.mat')

%%   % taking average model from k folds
% (2)Determine and rank which pixels in the MNIST set are 
% most informative for correctly labeling the digits.
% % for i=1:784
% %    a3_norm_temp=norm(a5(i,:),2);
% %    a3_norm(:,i)=a3_norm_temp;
% % end
% % image_a3=reshape(a3_norm,28,28);

% the first 25 digits look like
figure(1)                                       
colormap(gray)   
for i = 1:25                                    
    subplot(5,5,i)                              
    number = reshape(A_train(i,:), [28,28]);
    imagesc(number)  
end



% figure for 10 digit collectively, structure & weight
plot1(x,x_name,A_test,b_test);

% figure for 10 digit collectively, relative errors

relativeerror1(A_train,x,B_train,x_name);



%% Analysis 10 digits seperately
% Accuracy for 10 digits for 6 menthods with overall accuracy

[acuall6] = acu_sep(X,A_test,B_test,X_name);

% Structure & weights for 10 digits for 6 menthods
plot10(X,X_name,A_test,b_test);

%% filter to find key pixel

Xk = filter_X(X);

%% Structure & weights for 10 digits (only key pixel) for 6 menthods
Xk_name = X_name;
Xk(1) = [];
Xk(1) = [];
Xk_name(1) = [];
Xk_name(1) = [];

% Accuracy for 10 digits (only key pixel)  for 6 menthods with overall accuracy

[acuall6key] = acu_sep(Xk,A_test,B_test,Xk_name);

plot10(Xk,Xk_name,A_test,b_test);




%% analysis sepreately

zed = A_test*X1;

[rows, columns] = size(zed);
for row = 1 : rows
  [maxValue, indexOfMax] = max(zed(row, :));
  zed(row, indexOfMax) = 1;
end

close = [];
for i = 1:10
    check = zed(:,i) - B_test(:,i);
    check2 = check(check == 0);
    ones = B_test(:,i);
    ones2 = ones(ones == 1);
    [total,col] = size(ones2);
    [n,m] = size(check2);
    n;
    accuracy = n/total;
    close = [close ; accuracy]
end

total_acc = sum(close)/10
bar(close)





%%
% (3)Apply your most important pixels to the test data set 
% to see how accurate you are with as few pixels as possible.

B_evaltest=A_test*a5;
[max_value,max_index]=max(B_evaltest');
max_index(max_index==10)=0;
b_test_4=max_index';


acu = b_test_4 -  b_test;
accuracy = sum(sum(acu==0))/(length(acu));
% % B4(B4==10)=0; % Change Testing Labels back to 0 from 10
% bool=b_test_4==b_test; % Determine if they are equal or not
% 
% sum_bool=sum(bool);
% accuracy=(sum_bool/length(b_test)) % Percent Accuracy (81.15%);


%%

b1 = round(a1);
figure(2), subplot(2,3,1)
A1 = flipud(reshape(b1,28,[])); pcolor(A1)

figure(2), subplot(2,3,2)
A2 = flipud(reshape(a2,28,[])); pcolor(A2)

figure(2), subplot(2,3,3)
A3 = flipud(reshape(a3,28,[])); pcolor(A3)

figure(2), subplot(2,3,4)
A4 = flipud(reshape(a4,28,[])); pcolor(A4)

figure(2), subplot(2,3,5)
A5 = flipud(reshape(a5,28,[])); pcolor(A5)

%%
% (4)Redo the analysis with each digit individually 
% to find the most important pixels for each digit.
B4 = b_test';
x3 = a3';
x4 = a4'
for m=1:10
    B4(B4==0)=10;
    B4_iter=B4;
    for i=1:10000   %Change number to 1 when m=i, set to 0 otherwise
        if B4_iter(i)==m
            B4_iter(i)=1;
        else
            B4_iter(i)=0;
        end
    end
    
    for i=1:784
        x3_norm_temp=norm(x3(m,i),2);
        x3_norm(m,i)=x3_norm_temp;
    end
    image_x3=reshape(x3_norm(m,:).',28,28);
    figure(4);
    subplot(4,3,m),imagesc(image_x3);
    colorbar;
    
    B_evaltest2=A_test*x4';
    [max_value2,max_index2]=max(B_evaltest2');
    
    max_index2_iter=max_index2;
    for i=1:10000
        if max_index2_iter(i)==m
            max_index2_iter(i)=1;
        else
            max_index2_iter(i)=0;
        end
    end
    
    max_index2_iter(max_index2_iter==10)=0;
    B4_iter(B4_iter==10)=0; % Change Testing Labels back to 0 from 10
    
    sum_max_index2_iter(:,m)=sum(max_index2_iter);
    sum_B4_iter(:,m)=sum(B4_iter);
    accuracy2(:,m)=sum_max_index2_iter(:,m)/sum_B4_iter(:,m);
end

%%
%Evaluate relative errors
b1_eval=A_train*a1;
b2_eval=A_train*a2;
b3_eval=A_train*a3;
b4_eval=A_train*a4;
b5_eval=A_train*a5;

error1=norm(b1_eval-B_train)/norm(B_train,2);
error2=norm(b2_eval-B_train)/norm(B_train,2);
error3=norm(b3_eval-B_train)/norm(B_train,2);
error4=norm(b4_eval-B_train)/norm(B_train,2);
error5=norm(b5_eval-B_train)/norm(B_train,2);

figure(2)
y=[error1 error2 error3 error4 error5];
bar(y);
methods_labels={modename1,modename2,modename3,modename4,modename5};
xlabel('Method');
ylabel('Relative Error');
set(gca,'xticklabels',methods_labels)

%%
zed = A_test*a1;

[rows, columns] = size(zed);
for row = 1 : rows
  [maxValue, indexOfMax] = max(zed(row, :));
  zed(row, indexOfMax) = 1;
end

close = [];
for i = 1:10
    check = zed(:,i) - B_test(:,i);
    check2 = check(check == 0);
    ones = B_test(:,i);
    ones2 = ones(ones == 1);
    [total,col] = size(ones2);
    [n,m] = size(check2);
    n;
    accuracy = n/total;
    close = [close ; accuracy]
end

total_acc = sum(close)/10
bar(close)
%%

for i = 1:10
    check = zed(:,i) - B_test(:,i);
    check2 = check(check == 0);
    ones = B_test(:,i);
    ones2 = ones(ones == 1);
    [total,col] = size(ones2);
    [n,m] = size(check2);
    n;
    accuracy = n/total;
    close = [close ; accuracy]
end
%%

zed2 = A_test*a2;

[rows, columns] = size(zed2);
for row = 1 : rows
  [maxValue, indexOfMax] = max(zed2(row, :));
  zed2(row, indexOfMax) = 1;
end

close2 = [];
for i = 1:10
    check = zed2(:,i) - B_test(:,i);
    check2 = check(check == 0);
    ones = B_test(:,i);
    ones2 = ones(ones == 1);
    [total,col] = size(ones2);
    [n,m] = size(check2);
    n;
    accuracy = n/total;
    close2 = [close2 ; accuracy]
end

total_acc2 = sum(close2)/10
bar(close2)

%%
lassoPlot(a3,stats3)

close3 = [];
for i = 1:10
    [a3,stats3]=lasso(train_images,B_train(:,i),'Lambda', .01); 
    zed3 = test_images*a3;
    check = zed3 > .175;
    check2 = check + B_test(:,i);
    col1 = B_test(:,i);
    tot = col1(col1 == 1);
    correct = check2(check2 == 2);
    accuracy = size(correct)/size(tot);
    close3 = [close3 ; accuracy]
end

total_acc3 = sum(close3)/10
bar(close3)


imp = a3(a3~=0);
imp2 = abs(imp);
imp3 = imp2 >= .001;
important = imp3(imp3~=0);
size(important)

%%
%EXPLORATORY PCA RECONSTRUCTION

trainmean = mean(A_train);
train_tilde = train_images - trainmean;
M = (train_tilde'*train_tilde)/(59999);
[evec, eval] = eig(M);
total = sum(sum(eval));
eval = max(eval);

k = 104;
Vk = evec(:,((784-(k-1)):784));

test_tilde = test_images-trainmean;
test_k = test_tilde*Vk;
test_tilde_k = test_k*Vk';

sample = 1;
figure(3)
subplot(1,2,1)
imagesc(reshape(test_tilde(sample,:),[28,28]));
axis on
title("Original image sample")
subplot(1,2,2)
imagesc(reshape(test_tilde_k(sample,:),[28,28]));
axis off
title(sprintf("Reconstruction using %i eigenvectors",k))

H = (test_tilde'*test_tilde)/(9999);
[evec_test, eval_test] = eig(H);
total_test = sum(sum(eval_test));
eval_test = max(eval_test);

accuracy = sum(eval_test((748-k):784))/total_test
