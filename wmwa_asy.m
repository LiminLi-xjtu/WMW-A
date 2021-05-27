function [power,mu_hat,sigma_hat] = wmwa_asy(X,Y,Z)
alpha = 0.05;
X = X(:);
Y = Y(:);
Z = Z(:);
U = [X;Z];
V = [Y;Z];

m = length(X);
n = length(Y);
l = length(Z);
N = m + n + l;
s = n + l;
t = m + l;

%calculate theta_1 and theta_2
sum_1 = 0;
for i =1:m
    for j = 1:s
        sum_1 = sum_1 + (X(i) > V(j));
    end
end
theta_1 = sum_1/m/s;

sum_2 = 0;
for i =1:n
    for j = 1:t
        sum_2 = sum_2 + (Y(i) > U(j));
    end
end
theta_2 = sum_2/n/t;

%calculate the empirical distribution
F_X_V = my_empirical_dist(X,V);
F_Y_U = my_empirical_dist(Y,U);
F_U_X = my_empirical_dist(V,X);
F_V_Y = my_empirical_dist(U,Y);

%calculate the asymptotic mean and variance of WMW-A statistic under alternative hypothesis
Var_F_X_V = var(F_X_V);
Var_F_Y_U = var(F_Y_U);
Var_F_U_X = var(F_U_X);
Var_F_V_Y = var(F_V_Y);

Cov_F_U_X_F_Y_U = cov(F_U_X,F_Y_U(1:m));
Cov_F_V_Y_F_X_V = cov(F_V_Y,F_X_V(1:n));
Cov_F_X_V_F_Y_U = cov(F_X_V(n+1:end),F_Y_U(m+1:end));
Cov_1_2 = - ((n+l) * Cov_F_U_X_F_Y_U + (m+l) * Cov_F_V_Y_F_X_V - l * Cov_F_X_V_F_Y_U);

Var_1 = (n+l)^2 / m * Var_F_U_X + (n+l) * Var_F_X_V;
Var_2 = (m+l)^2 / n * Var_F_V_Y + (m+l) * Var_F_Y_U;

mu_hat = (n + l) * theta_1 + (m + 1) / 2 - (m + l) * theta_2 - (n + 1) / 2;
sigma_hat = Var_1 + Var_2 - 2 * Cov_1_2(1,2);

%calculate the mean and variance of WMW-A statistic under null hypothesis
mu = 0;
all = [X; Y; Z];
if length(unique(all)) == (m + n + l)
    sigma_0 = (m + n + l + 1) / 12 * (( n + l) / m + ( m + l) / n + 2);
else
    tall = tabulate(all);
    ind = find(tall(:,2) > 1);
    sm = 0;
    for h = 1:length(ind)
        sm = sm + tall(ind,2)^3 - tall(ind,2);
    end
    sigma_0 = (12 / (N + 1) - sm / 12 / N / (N - 1)) * ((n + l) / m + (m + l) / n + 2);
end

%calculate the power of WMW-A test
delta = (mu_hat - mu) / sqrt(sigma_0);
sigma_1 = sqrt(sigma_hat / sigma_0);    

u_1 = norminv(1 - alpha /2);
Phi_1 = normcdf((u_1 - delta) / sigma_1);

u_2 = norminv(alpha /2);
Phi_2 = normcdf((u_2 - delta) / sigma_1);

power = 1 - (Phi_1 - Phi_2);