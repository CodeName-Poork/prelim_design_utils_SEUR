function [alpha_slice, Fy] = axleCal(veh, tire, which_axle, track, cg_h, plot_flag,res_resolution)
if which_axle == "front" %|| which_axle == 0
    Fz_norm = 9.8 * veh.m * (veh.l - veh.a) / veh.l;
elseif which_axle == "rear" %|| which_axle == 1
    Fz_norm = 9.8 * veh.m * veh.a / veh.l;
end

delta_Fz = linspace(0,Fz_norm/2,res_resolution)';
Fy = delta_Fz * track/cg_h;
alpha_slice = zeros(length(delta_Fz),1);
for i =  1:length(delta_Fz) %solve for Fz: one at a time
    syms alpha_solve
    f = magicBCDE(tire.mu, tire.c1, tire.c2, tire.C, tire.E, alpha_solve, Fz_norm/2 + delta_Fz(i)) + ...
        magicBCDE(tire.mu, tire.c1, tire.c2, tire.C, tire.E, alpha_solve, Fz_norm/2 - delta_Fz(i)) ... 
        - Fy(i);
    alpha_out = vpasolve(f, alpha_solve, 0);
    if isempty(alpha_out)
        alpha_out = NaN;
    end
    alpha_slice(i) = alpha_out;
end


alpha_slice_aux = zeros(length(delta_Fz),1);
for i =  1:length(delta_Fz) %solve for Fz: one at a time
    syms alpha_solve
    f = magicBCDE(tire.mu, tire.c1, tire.c2, tire.C, tire.E, alpha_solve, Fz_norm/2 + delta_Fz(i)) + ...
        magicBCDE(tire.mu, tire.c1, tire.c2, tire.C, tire.E, alpha_solve, Fz_norm/2 - delta_Fz(i)) ... 
        - Fy(i);
    alpha_out_2 = vpasolve(f, alpha_solve, 0.4);
    if isempty(alpha_out_2) || alpha_out_2 < 0 || alpha_out_2 > 0.4
        alpha_out_2 = NaN;
    end
    alpha_slice_aux(i) = alpha_out_2;
end


if plot_flag == 1 % You gonna plot this shite and all?
    alpha = linspace(0,deg2rad(20),length(delta_Fz));
    [delta_Fz_2d, alpha_2d] = meshgrid(delta_Fz, alpha);
    Fy_2d = magicBCDE(tire.mu, tire.c1, tire.c2, tire.C, tire.E, alpha_2d, Fz_norm/2 + delta_Fz_2d) + ...
            magicBCDE(tire.mu, tire.c1, tire.c2, tire.C, tire.E, alpha_2d, Fz_norm/2 - delta_Fz_2d);
    figure(20)
    p3 = plot3(delta_Fz,alpha_slice,Fy); hold on;
    pa = plot3(delta_Fz,alpha_slice_aux,Fy); hold on;
    ms = mesh(delta_Fz_2d, alpha_2d,Fy_2d);
    ms.FaceAlpha = 0;
    ms.EdgeColor = [0.1,0.1,0.1];
    ms.EdgeAlpha = 0.3;
    p3.LineWidth = 1;
    pa.LineWidth = 1;
    pa.Color = p3.Color;
    pa.LineStyle = '--';
    grid on;
    xlabel('\delta Fz [N]');
    ylabel('\alpha [deg]');
    zlabel('axle lateral force');
end
alpha_slice = [alpha_slice; alpha_slice_aux];
Fy = [Fy; Fy];

end