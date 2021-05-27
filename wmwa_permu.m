function p = wmwa(x,y,z,num_perm)
nx = length(x);
ny = length(y);
nz = length(z);
x = x(:);   % ensure columns
y = y(:);
z = z(:);

%Compute the WMW-A statistic on the observations
Wx_obs = compute_ranksum_obs(x,[y;z]); %compute the sum of the ranks of observations of X-sample
Wy_obs = compute_ranksum_obs(y,[x;z]); %compute the sum of the ranks of observations of Y-sample
W_obs = Wx_obs / nx - Wy_obs / ny; %WMW-A statistic


all = [x;y;z];
label(1:nx) = 1;
label(nx + 1 : nx + ny) = 2;
label(nx + ny + 1 : nx + ny + nz) = 3;

for k = 1:num_perm
    %Randomly permutate the observations of three samples
    plabel(k,:) = label(randperm(nx + ny + nz));
    px = all(plabel(k,:) == 1);
    py = all(plabel(k,:) == 2);
    pz = all(plabel(k,:) == 3);
    
    %Compute the WMW-A statistic on the new set of observations
    Wx_null(k) = compute_ranksum_obs(px,[py;pz]);
    Wy_null(k) = compute_ranksum_obs(py,[px;pz]);
    W_null(k) = Wx_null(k) / nx - Wy_null(k) / ny;
end

%compute p-value
plo = sum( W_null <= W_obs) / num_perm ;
phi = sum( W_null >= W_obs) / num_perm ;
p_tail = min(plo,phi);
p = min(2*p_tail, 1);
end