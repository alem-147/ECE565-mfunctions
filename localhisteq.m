function g = localhisteq(f, m, n)
    arguments
        f (:,:) 
        m (1,1) {mustBeInteger, mustBePositive} = 3
        n (1,1) {mustBeInteger, mustBePositive} = m
    end

%references 
%matlab docs [1]
%ECE 566 Dr. Brankov notes on nerual networks (Mask stride) [2]

% throw error on bad arg
if (mod(m,2) ~= 1) | (mod(n,2) ~= 1)
    error('arguments m and n must be an odd value')
end

if ~ismatrix(f)
    error('f must be a 2d matrix')
end

%extend f
%from [2] : len_out = (len_in - mask_len + 2*padding)/stride + 1
% eg hor_len(m-1)/2 = padding
hor_padding = size(f,1)*(m-1)/2;
vert_padding = size(f,2)*(n-1)/2;
fext = wextend('2D', 'sym', f, [hor_padding vert_padding]);

%init output
g = zeros(size(f));

%loop through the center of each neighboorhood
for i = 1:size(f,1)
    for j = 1:size(f,2)
        fexti = i + hor_padding;
        fextj = j + vert_padding;
        local_window = fext(fexti-(m-1)/2:fexti+(m-1)/2, fextj-(n-1)/2:fextj+(n-1)/2);
        h = histcounts(local_window, 0:255);
        T = cumsum(h) / numel(local_window);
        g(i,j) = T(f(i,j) +1);
    end
end