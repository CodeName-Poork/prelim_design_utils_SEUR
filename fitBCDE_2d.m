function tir_fit = fitBCDE_2d(alpha_data_raw, fy_data_raw, fz_data_raw)
%% Data Laundary
valid_idx = ~isnan(alpha_data_raw);
alpha_data = alpha_data_raw(valid_idx);
fy_data = fy_data_raw(valid_idx);
fz_data = fz_data_raw(valid_idx);

%%
x0 = [0.8, 60000, 400, 1.5, -1.0]; % Initial guess of th parameters

% upper and lower bounds of the formula
lb = [0.1, -50000, -50000, -10, -10];
ub = [3, 500000, 50000, 10, 10];

xdata = [alpha_data, fz_data];

% function to be fitted
fit_fun = @(params, alpha) magicBCDE(params(1), params(2), params(3), ...
                                     params(4), params(5), ...
                                     xdata(:,1), xdata(:,2));
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
    lsqcurvefit(fit_fun, x0, xdata, fy_data, lb, ub, options);

tir_fit.mu = params_fit(1);
tir_fit.c1 = params_fit(2);
tir_fit.c2 = params_fit(3);
tir_fit.C  = params_fit(4);
tir_fit.E  = params_fit(5);