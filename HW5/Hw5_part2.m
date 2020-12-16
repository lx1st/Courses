clear all; close all; clc
%% II(a)
%   Power iterate on the matrix of images to find the dominant eigenvector and eigenvalue
%   Compare it to the leading order SVD mode.


%% read images
A = [];
count = 0;

% image size
m = 192;
n = 168;

% picture numbers in each folder
N = 64;
K = 39;

avg = zeros(m*n,1);

for i = 1:K
    if i == 14
        continue
    end
    
    data_dir = "/Users/linxiao/Documents/MATLAB/Amath_584/Hw_5/CroppedYale/yaleB";
    folder_dir = strcat(data_dir, ...
        num2str(i,'%02d'), '/');
    files = dir(folder_dir);
    
    
    for j = 1:N
        %         figure(1)
         ff = files(2+j).name;;
        u = imread(folder_dir + ff); % Read the image into a matrix
        %         imshow(u)
        if(size(u,3)==1)
            M=double(u);
        else
            M=double(rgb2gray(u));
        end
        %         pause(0.1);
        R = reshape(M,m*n,1);
        A = [A, R];
        avg = avg + R;
        count = count + 1;
    end
end

%% SVD
avg = avg/count;

[U1,S1,V1] = svd(A,0);
% interpretate the U, S, V matrix
numImg = size(A, 2);
Phi = U1(:,1:numImg);
Phi(:,1) = -1*Phi(:,1);

% plot the first reshaped coumns of matrix U
figure(1)
imshow(uint8(25000*reshape(Phi(:, 1),m,n)));

%% Power iteration
max_iter = 30;
v0 = randn(m*n, 1);

A2 = [A, zeros(size(A, 1), size(A, 1)-size(A, 2))];

[eigenval,eigenvec] = Power_Iter2(A2,v0,max_iter)

figure(2)
imshow(uint8(25000*reshape(eigenvec,m,n)));

%% Use randomized sampling to reproduce the SVD matrices:
% stage A
K = 30;
omega = rand(size(A,2),K)
Y = A * omega;
[Q, R] = qr(Y, 0);

% stage B
B = (Q') * A;
[U2, S2, V2] = svd(B, 'econ');
uapprox = Q * U2;

% plot the first reshaped coumns of matrix U
figure(3)
imshow(uint8(25000*reshape(-uapprox(:, 1),m,n)));

%% Compare the randomized modes to the true modes along with the singular
%  value decay as a function of the number of randomized samples.
gt_singular = diag(S1);
figure(4)
plot([1:K], diag(S2), '-', 'LineWidth',2)
hold on 
plot([1:K], gt_singular(1:K), '--', 'LineWidth',2)
legend('randomized sampling mode','true mode')

