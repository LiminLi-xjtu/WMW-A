function cump_y = my_empirical_dist(x, y)
if min(size(x))~=1
    error('data must be a vector')
end

% calculate the cumulative distribution function of x
n = length(x);
x_sort = sort(x);
[u,a] = unique(x_sort);
frequency = [a(1);diff(a)];
cump_x = cumsum(frequency)/n;

% calculate the cumulative distribution function of y under the CDF of x
for i = 1:length(y)
    temp = [];
    temp = find(y(i) >= u);
    if ~isempty(temp)
        ind_y = temp(end);
        cump_y(i) = cump_x(ind_y);
    else
        cump_y(i) = 0; 
    end
end