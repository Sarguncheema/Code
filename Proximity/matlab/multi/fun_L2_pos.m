 function p = fun_L2_pos(x, gamma, dir)
%function p = fun_L2_pos(x, gamma, dir)
%
% This procedure evaluates the function:
%
%                    f(x) = gamma * ||x||_2 + \iota_{[0,+\infty)^N}(x)
%
% When the input 'x' is an array, the computation can vary as follows:
%  - dir = 0 --> 'x' is processed as a single vector [DEFAULT]
%  - dir > 0 --> 'x' is processed block-wise along the specified direction
%
%  INPUTS
% ========
%  x     - ND array
%  gamma - positive, scalar or ND array compatible with the blocks of 'x'
%  dir   - integer, direction of block-wise processing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version : 1.0 (09-05-2018)
% Author  : Emilie Chouzenoux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C) 2017
%
% This file is part of the codes provided at http://proximity-operator.net
%
% By downloading and/or using any of these files, you implicitly agree to 
% all the terms of the license CeCill-B (available online).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% default inputs
if nargin < 3 || (~isempty(dir) && dir == 0)
    dir = [];
end

% check input
sz = size(x); sz(dir) = 1;
if any( gamma(:) <= 0 ) || ~isscalar(gamma) && (isempty(dir) || any(size(gamma)~=sz))
    error('''gamma'' must be positive and either scalar or compatible with the blocks of ''x''')
end
%-----%


% linearize
if isempty(dir)
    x = x(:); 
end
    
% evaluate the function
xx = gamma .* sqrt( sum(x.^2, dir) );

% check the constraint
mask = (x > 0);

% evaluate the indicator function
if all(mask(:))
    p = sum( xx(:) );
else
    p = Inf;
end


