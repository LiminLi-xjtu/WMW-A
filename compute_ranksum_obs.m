function [W_obs,xrank] = compute_ranksum_obs(x,y)

nx = numel(x);
ny = numel(y);

x = x(:);   % ensure columns
y = y(:);

% Compute the rank sum statistic based on the smaller sample
[ranks, tieadj] = tiedrank([x; y]);
xrank = ranks(1:nx);
W_obs = sum(xrank);

end
