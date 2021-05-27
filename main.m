
clear;

generate_data;
B = 1000; %Number of permutations
sig_level = 0.05; %significance level

tic
for d = 1:length(alpha_2)
    for i = 1:length(m_list)
        [d i]
        m = m_list(i);%sample size of X-sample
        n = n_list(i); %sample size of Y-sample
        for j = 1:T %trial times
            x = X{d,i,j};y = Y{d,i,j}; %observations of population X and Y
            pwmw(i,j) = ranksum(x,y); %p-value of WMW test
            [~,pt(i,j)] = ttest2(x,y,'tail','both'); %p-value of t-test
            
            %p-value of WMW-A test
            allmin = min([x y]);
            allmax = max([x y]);
            for k = 1:length(K) %auxiliary sample size
                z = Z{k,d,i,j};
                %remove the observations for Z-sample outside the range of the observations for the pooled X and Y samples
                idx = intersect(find(z >= allmin),find(z <= allmax));
                z = z(idx);
                pwmwa(i,k,j) = wmwa_permu(x,y,z,B);
            end
        end
        
        %compute the estimated powers of WMW test, t-test and WMW-A test
        power_wmw(d,i) = length(find(pwmw(i,:) <= sig_level))/T;
        power_t(d,i) = length(find(pt(i,:) <= sig_level))/T;
        for k = 1:length(K)
            power_wmwa(d,i,k) = length(find(pwmwa(i,k,:) <= sig_level))/T;
        end
        
    end
end
toc
save result_balanced power_wmwa power_wmw power_t m_list n_list T K alpha_1 alpha_2 beta;
plot_gamma_power
% save result_unbalanced power_wmwa power_wmw power_t m_list n_list T K alpha_1 alpha_2 beta;