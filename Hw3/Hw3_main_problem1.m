clear all
close all
clc


A = randn(10,7);
A_cond_origin = cond(A);


A(:,7) = A(:, 1);
A_ill = A;
Cond_A_ill = cond(A_ill);
A_Noi = A+ randn(10, 7)*1e-12;


[Q_House,R_House] = qrfactor(A_ill);
[Q_Mod,R_Mod] = modified_gram_schm(A_ill);
[Q,R] = qr(A_ill);

[Q_House_Noi,R_House_Noi] = qrfactor(A_Noi);
[Q_Mod_Noi,R_Mod_Noi] = modified_gram_schm(A_Noi);
[Q_Noi,R_Noi] = qr(A_Noi);


Q_diff_House_Noi = Q_House_Noi - Q_House;
Q_diff_Mod_Noi = Q_Mod_Noi - Q_Mod;
Q_diff_Noi = Q_Noi - Q;
Mean_House = mean(abs(Q_diff_House_Noi));
Mean_Mod = mean(abs(Q_diff_Mod_Noi));
Mean = mean(abs(Q_diff_Noi));