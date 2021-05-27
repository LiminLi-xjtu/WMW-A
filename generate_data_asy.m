clear;
m_list = [2,4,5,8,10,12,15,18,20,25,30,40,50];
n_list = m_list;
T = 1000; %trial times
K = 2; %auxiliary sample size
alpha_1 = 0.5;
alpha_2 = 2; 
beta = 1; % X~Gamma(alpha_1,beta), Y~Gamma(alpha_2,beta)
for d = 1:length(alpha_2) %degree of the shift between the two population distributions
    for i = 1:length(m_list)
        for j = 1:T
            m = m_list(i); %sample size of X-sample
            n = n_list(i); %sample size of Y-sample
            X{d,i,j} = gamrnd(alpha_1,beta,[1,m]);
            Y{d,i,j} = gamrnd(alpha_2(d),beta,[1,n]);
            for k = 1:length(K)
                Z{k,d,i,j} = [gamrnd(alpha_1,beta,[1, K(k)*m]), gamrnd(alpha_2(d),beta,[1, K(k)*n])];
            end
        end
    end
end

save data_asy X Y Z m_list n_list T K alpha_1 alpha_2 beta;