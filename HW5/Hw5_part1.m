clear all; close all; clc
%% I(a)
%   Create symmetric matrix
%   Use Eigs commond to get the ground truth eigenvalues and eigenvectors
m = 10;
M = tril(randn(m,m));
A = M + M' + eye(10);
% pcolor(A);
[V,D] = eigs(A,10);
D = sort(diag(D),'descend');

figure(1); plot(1:10, D, '*'); ylabel('ground truth eigenvalues');

%% I(b)
%   Find the largest eigenvalue with the power iteration method
%   Compare Compare the accuracy of the method as a function of iterations.

max_iter = 30;
v0 = rand(m,1); 


[eigenval,eigenval_err] = Power_Iter(A,v0,D,max_iter);

figure(2)
plot([1:max_iter], eigenval_err);
xlabel('Iteration')
ylabel('Error  of power iteration')

%% I(c)
%   Find all ten eigenvalues by Rayleigh Quotient iteration and guessing initial ”eigenvectors”.
%   Compare the accuracy of the method as a function of iterations and discuss your initial guesses to find all eigen- value/eigenvector pairs.

guessnum = 10;
eigenval_rq = zeros(1, guessnum);
eigenvec_rq = zeros(m, guessnum);

v0 = rand(m,1);

for i = 1:guessnum
    [eigenval_rq(i),eigenvec_rq(:,i)] = Rayleigh_Quotient_Iter(A,v0);
    v0 = rand(m,1);v0 = v0/norm(v0);
    % Subtract off orthogonal eigenvectors to speed up process
    v0 = v0 - eigenvec_rq(:,1:i)*((eigenvec_rq(:,1:i))'*v0);
end

eigenval_rq = sort(eigenval_rq,'descend');

figure(3);plot(eigenval_rq,'o');ylabel('Eigenvalue');
hold on
plot(D','*'); hold off;
legend('Results of RQIter','Groud Truth');

%% I(d)
%   Repeat (b) and (d) with a random matrix that is not symmetric.

clear all; close all; clc


m = 10;
A = rand(m)
[V,D] = eigs(A,10);
D = sort(diag(D),'descend');
figure(4);plot(D,'*');xlabel('Real (Eigenvalue)');ylabel('Imag (Eigenvalue)');


 
%   Find the largest eigenvalue by power iteration method 

max_iter = 30;
v0 = randn(m,1)
[eigenval,eigenval_err] = Power_Iter(A,v0,D,max_iter);
figure(5)
plot(1:max_iter, eigenval_err); xlabel('Iteration'); ylabel('Error of the eigvalue by power iteration')

%%

guessnum = 10;
eigenval_rq = zeros(1, guessnum);
eigenvec_rq = zeros(m, guessnum);

% v0 = rand(m,1) + 1i*rand(m,1);
v0 = 2*rand(m,1)-ones(m,1)+ (2*rand(m,1)-ones(m,1))*1i;
for i = 1:guessnum
    [eigenval_rq(i),eigenvec_rq(:,i)] = Rayleigh_Quotient_Iter(A,v0);
    v0 = rand(m,1);v0 = v0/norm(v0);
% Subtract off orthogonal eigenvectors to speed up process
   v0 = v0 - eigenvec_rq(:,1:i)*((eigenvec_rq(:,1:i))'*v0);
end

eigenval_rq = sort(eigenval_rq,'descend');

err = eigenval_rq - sort(D');

figure(7);plot(eigenval_rq, 'o');ylabel('Eigenvalue');
hold on
plot(real(D),imag(D),'*'); hold off;
legend('Results of RQIter','Groud Truth');


