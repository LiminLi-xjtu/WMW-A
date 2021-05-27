%%%%%%%%%%%%%%%%%%%%%%%balanced case
clear;
m_list = [2,4,5,8,10,12,15,18,20,25]; 
n_list = m_list;
T = 1000; %trial times
K = [2 5 10]; %auxiliary sample size
alpha_1 = 0.5;
alpha_2 = [1,1.5,2,2.5]; 
beta = 1; % X~Gamma(alpha_1,beta), Y~Gamma(alpha_2,beta)
for d = 1:length(alpha_2) %degree of the shift between the two population distributions
    for i = 1:length(m_list)
        for j = 1:T
            m = m_list(i); %sample size of X-sample
            n = n_list(i); %sample size of Y-sample
            X{d,i,j} = gamrnd(alpha_1,beta,[1,m]);
            Y{d,i,j} = gamrnd(alpha_2(d),beta,[1,n]);
            for k = 1:length(K)
                Z{k,d,i,j} = [gamrnd(alpha_1,beta,[1, K(k)*n]), gamrnd(alpha_2(d),beta,[1, K(k)*n])];
            end
        end
    end
end

save data_balanced X Y Z m_list n_list T K alpha_1 alpha_2 beta;

%%%%%%%%%%%%%%unbalanced case
% clear;
% n_list = [10 15 20 25 30 40 50 60 80 100];%sample size of Y-sample
% m_list = 5 * ones(1, length(n_list)); %sample size of X-sample
% T = 1000; %trial times
% K = [2 5 10]; %auxiliary sample size
% alpha_1 = 0.5;
% alpha_2 = [1,1.5,2,2.5];
% beta = 1; % X~Gamma(alpha_1,beta), Y~Gamma(alpha_2,beta)
% for d = 1:length(alpha_2) 
%     for i = 1:length(m_list)
%         for j = 1:T
%             m = m_list(i); 
%             n = n_list(i); 
%             X{d,i,j} = gamrnd(alpha_1,beta,[1,m]);
%             Y{d,i,j} = gamrnd(alpha_2(d),beta,[1,n]);
%             for k = 1:length(K)
%                 Z{k,d,i,j} = [gamrnd(alpha_1,beta,[1, K(k)*n]),gamrnd(alpha_2(d), beta, [1, K(k)*n])];
%             end
%         end
%     end
% end
% 
% save data_unbalanced X Y Z m_list n_list T K alpha_1 alpha_2 beta;