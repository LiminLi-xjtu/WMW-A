
clear;

generate_data_asy;
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

            %p-value of WMW-A test by asymptotic distribution and permutation test
            allmin = min([x y]);
            allmax = max([x y]);
            for k = 1:length(K) %auxiliary sample size
                z = Z{k,d,i,j};
                %remove the observations for Z-sample outside the range of the observations for the pooled X and Y samples
                idx = intersect(find(z >= allmin),find(z <= allmax));
                z = z(idx);
                [pwmwa_asy(d,i,k,j),~,~]=wmwa_asy(x,y,z);
                pwmwa(i,k,j) = wmwa_permu(x,y,z,B);
            end
        end
        
        %compute the estimated powers of WMW-A test under asymptotic distribution and permutation test
        for k = 1:length(K)
            power_wmwa_asy(d,i,k) = sum(pwmwa_asy(d,i,k,:))/T;
            power_wmwa(d,i,k) = length(find(pwmwa(i,k,:) <= sig_level))/T;
        end
    end
    
end
toc

save result_asy power power_wmwa_asy power_wmwa m_list n_list T K alpha_1 alpha_2 beta;
plot_asy_power