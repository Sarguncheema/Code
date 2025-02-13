function [x, obj, y_1, y_2, temp,temp_crit] = Primal_Dual(c, m, n, collect_obj, tol)
%%
% Primal_Dual(c, m, n, tol) : Executes the Primal-Dual algorithm
% applied to problems on optimal transport.
%
% **Input:**
% c:   cost matrix of size MxN
% m:   discrete probability vector of size M
% n:   discrete probability vector of size N
% collect_obj: boolean value; if true, then all objective values are stored
% tol: numerical tolerance of the algorithm: it stops if the norm between a
%      pair of iterations is less than this value (default tol = 1e-4)
%
% **Output:**
% x:    best feasible point found after optimisation
% obj:  objective value at x
% y:    Pair of dual variables
% temp: time it took to compute x
%%

    if nargin < 5
        tol = 1e-5;
    end
    % Recover M and N
    M = length(m);
    N = length(n);

    % Initialise tau
    tau = 0.0001;
    % Initialise sigma
    sig = 1/(tau * 2) - 0.5;
    % Invert sigma
    isig = 1/sig;

    % Initialise x, it doesn't have to be feasible
    x = (m + n')/(N + M);
    % Intialise dual variables y_1 and y_2
    y_1 = zeros(M,N);
    y_2 = zeros(M,N);
    y_1(:,1) = m;
    y_2(1,:) = n;

    %% Controls
    % iters controls the number of iterations
    iters = 1000;                                 %% increase
    % The distance between points will serve as stopping criteria
    %norm_difference = Inf;
    
    
    % Objective value
    obj = [];
    % initial objective calculation
    if collect_obj
        obj = [sum(c.*x,'all')];
    end
    
    tStart = tic;
    
    % Display time at different intervals
    temp_crit = [];
    crit_tol = [];
    for i = [0:5]
        crit_tol(end+1) = 5 * 10 ^ (-i);
        crit_tol(end+1) = 1 * 10 ^ (-i);
    end
    j = 1;
    
    %% Now we perform the Primal-Dual iteration:
    for it = 1:iters
        % Update x
        u = x - tau * c - tau * (y_1 + y_2);
        % Update x using the projection over the simplex C_1^m
        v_1 = y_1 + sig * (2 * u - x) - sig * project_simplex( isig * y_1 + 2 * u - x, m, 2);
        % Update x using the projection over the simplex C_2^n
        v_2 = y_2 + sig * (2 * u - x) - sig * project_simplex( isig * y_2 + 2 * u - x, n', 1);

        % Iterate info
        norm_difference = norm(x-u);
        %Average objective from 2 previous
        aver_obj = (sum(c.*u,'all') + (sum(c.*x,'all')))/2;
        
        % Update for the next iteration
        x   = u;
        y_1 = v_1;
        y_2 = v_2;
        % Store objective if needed
        if collect_obj
            obj(end+1) = sum(sum(c.*x));
        end
        % Store temp for certain tolerance
        if abs(aver_obj - 1) < crit_tol(j)
            temp_crit(end+1) = toc(tStart);
            j = j + 1;
        end

        if abs(aver_obj - 1) < tol
            break
        end

    end
    % Update time clock
    temp = toc(tStart);
    obj(end+1) = sum(sum(c.*x));
    % See order of magnitude and number of iterations
    [log(norm_difference)/log(10), int16(it)]
