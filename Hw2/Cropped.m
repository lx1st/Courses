clear all
close all
clc

A = []; 
count = 0;

%% cropped_SVD
    % Size of each picture
    m = 192;
    n = 168;
    % Number of sample pictures
    N = 64;
    K = 39;
    % K = 3;
    avg = zeros(m*n,1);  % the average face
    % read cropped dataset
    for i = 1:K
        if i == 14
            continue
        end
        folder_dir = strcat('yalefaces_cropped/CroppedYale/yaleB',num2str(i,'%02d'), '/');
        files = dir(folder_dir); % find all the files under the folder
        for j = 1:N
    %         figure(1)
            ff = files(2+j).name;
            u = imread(ff); % Read the image into a matrix
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

%% "averaged" face_Cropped
avg = avg /count;
avgTS = uint8(reshape(avg,m,n));
figure(1), imshow(avgTS);

A = A - avg;

%%  Computing the SVD
[U,S,V] = svd(A,0);

%% interpretate the U, S, V matrix
numImg = size(A, 2);
Phi = U(:,1:numImg);
Phi(:,1) = -1*Phi(:,1);
% plot the first 9 reshaped coumns of matrix U
figure(2)
count = 1;
for i=1:3
    for j=1:3
        subplot(3,3,count)
        imshow(uint8(25000*reshape(Phi(:,count),m,n)));
        count = count + 1;
    end
end

%% PCA analysis
sigular_value_spctrum = [];
for i = 1:numImg
    sigular_value_spctrum = [sigular_value_spctrum, S(i,i)];
end
figure(3)
plot([1:numImg], sigular_value_spctrum/sigular_value_spctrum(1))
axis([0,500, 0, 1])
xlabel('index')
ylabel('singular value')
title('singular values spectrum Cropped')

%% reconstruct images with PCA basis
figure(4)
num_PCAbasis = 200;
image1 = U(:, 1:num_PCAbasis)*S(1:num_PCAbasis, 1:num_PCAbasis)*V(1, 1:num_PCAbasis)';
imshow(uint8(reshape(image1,m,n)))

