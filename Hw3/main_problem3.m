
% Check the condition number
clc
clear all
close all

%% the relationship between condition number & matrix size
cond_mat = zeros(10);
for iter = 1:100
    for m = 2:10
        for n =1:m-1
            A = randn(m, n);
            cond_mat(m, n) = cond_mat(m, n) + cond(A);
        end
    end
end
cond_mat = cond_mat/100;

%% 3.2 appending column
m = 5;
n = 4;
A = randn(m, n);
cond(A)
A1 = [A, A(:, 1)];
cond(A1)
det(A1)

%% 3.3 adding noise 
cond_list = [];
for noi_lev = 4:16
    A1_temp = A1;
    A1_temp(:, n+1) = A1_temp(:, n+1) + rand(m, 1) * 10^(-noi_lev);
    cond_list = [cond_list, cond(A1_temp)];
end

figure(1)
plot([4:16], cond_list)