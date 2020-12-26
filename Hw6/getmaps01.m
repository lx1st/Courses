clear; close all; clc

%% Load training and test sets just once
% computer map matrix

A_train = loadMNISTImages('train-images.idx3-ubyte');
b_train = loadMNISTLabels('train-labels.idx1-ubyte');
A_test = loadMNISTImages('t10k-images.idx3-ubyte');
b_test = loadMNISTLabels('t10k-labels.idx1-ubyte');
num_A_train = length(b_train);
num_A_test = length(b_test);

%% Pre-processing the images to make them binary images

% A_train_bin = NaN(size(A_train));
% A_test_bin = nan(size(A_test));
% 
% 
% for ii = 1: 1: num_A_train
%     temp = reshape(A_train(:, ii), [28, 28]);
%     temp = imbinarize(uint8(temp)); % Threshold given by Otsu's method
%     A_train_bin(:, ii) = temp(:);
%     if ii <= num_A_test
%         temp = reshape(A_test(:, ii), [28, 28]);
%         temp = imbinarize(uint8(temp)); % Threshold given by Otsu's method
%         A_test_bin(:, ii) = temp(:);
%     end        
% end

A_train = transpose(A_train);
A_test = transpose(A_test);

% onehotencode

tr_labels = categorical(b_train);
classes = ["1","2","3","4","5","6","7","8","9","0",];
B_train = onehotencode(tr_labels,2,"ClassNames",classes);


te_labels = categorical(b_test);
B_test = onehotencode(te_labels,2,"ClassNames",classes);

% computer x, Ax=b
x1=pinv(A_train)*b_train; modenamex1 = 'b*pinv';

x2=A_train\b_train; modenamex2 = 'b/x';

x3=lasso(A_train,b_train,'Lambda', 0.1); modenamex3 = 'lasso (lambda = 0.1)';

x4=lasso(A_train,b_train,'Lambda', 0.05); modenamex4 = 'lasso (lambda = 0.05)';

x5=lasso(A_train,b_train,'Lambda', 0.01); modenamex5 = 'lasso (lambda = 0.01)';

x6=lasso(A_train,b_train,'Lambda', 0); modenamex6 = 'ridge';


% computer X, AX=B

X1=pinv(A_train)*B_train; modenameX1 = 'B*pinv';

X2=A_train\B_train; modenameX2 = 'B/X';


X3_save = zeros(784,10);
for i=1:10
X3=lasso(A_train,B_train(:,i),'Lambda', 0.1);        
X3_save(:,i)=X3;
end
X3=X3_save; modenameX3 = 'lasso (lambda = 0.1)';

X4_save = zeros(784,10);
for i=1:10
X4=lasso(A_train,B_train(:,i),'Lambda', 0.05);        
X4_save(:,i)=X4;
end
X4=X4_save; modenameX4 = 'lasso (lambda = 0.05)';

X5_save = zeros(784,10);
for i=1:10
X5=lasso(A_train,B_train(:,i),'Lambda', 0.01);        
X5_save(:,i)=X5;
end
X5=X5_save; modenameX5 = 'lasso (lambda = 0.01)';


X6_save = zeros(784,10);
for i=1:10
X6=lasso(A_train,B_train(:,i),'Lambda', 0);    
X6_save(:,i)=X6;
end
X6=X6_save; modenameX6 = 'ridge';

%%
x_name = {modenamex1, modenamex2,modenamex3,modenamex4,modenamex5,modenamex6};
X_name = {modenameX1,modenameX2,modenameX3,modenameX4,modenameX5,modenameX6};
num = {'1','2','3','4','5','6','7','8','9','0'};
x = {x1 x2 x3 x4 x5 x6};
X = {X1 X2 X3 X4 X5 X6};


save('data01.mat');

