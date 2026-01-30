function tir_fit = fitBCDE(alpha_data_raw, fy_data_raw, fz_fixed)
%% Data Laundary
valid_idx = ~isnan(alpha_data_raw);
alpha_data = alpha_data_raw(valid_idx);
fy_data = fy_data_raw(valid_idx);

%%
x0 = [0.8, 60000, 400, 1.5, -1.0]; % Initial guess of th parameters

% upper and lower bounds of the formula
lb = [0.1, 1, 1, 1, -5.0];
ub = [2, 500000, 50000, 2.5, 1.0];

% function to be fitted
fit_fun = @(params, alpha) magicBCDE(params(1), params(2), params(3), ...
                                     params(4), params(5), ...
                                     alpha, fz_fixed);
% function [fyout] = magicBCDE (mu, c1, c2, C, E, alfin, fzin)
%% LS fititng
options = optimoptions('lsqcurvefit', ...
    'Display', 'iter', ...      % display iteration
    'Algorithm', 'trust-region-reflective', ... 
    'MaxFunctionEvaluations', 3000, ...
    'MaxIterations', 1000, ...
    'FunctionTolerance', 1e-8, ...
    'StepTolerance', 1e-8);

[params_fit, resnorm, residual, exitflag, output] = ...
    lsqcurvefit(fit_fun, x0, alpha_data, fy_data, lb, ub, options);

tir_fit.mu = params_fit(1);
tir_fit.c1 = params_fit(2);
tir_fit.c2 = params_fit(3);
tir_fit.C  = params_fit(4);
tir_fit.E  = params_fit(5);
