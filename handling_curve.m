function [ay_handle, x_handle, alpha1, alpha2] = handling_curve(veh)
a = .a;

l = car.l;
b = l - a;
m = car.m;

Fzf = m*9.8/l*b;
Fzr = m*9.8/l*a;
alpha = deg2rad(linspace(0,20,101));
Fyf = magic_quick(axle_f.mu, - axle_f.C_Fy, axle_f.C, axle_f.E, Fzf, alpha);
Tyf = Fyf * a;
Fyr = magic_quick(axle_r.mu, - axle_r.C_Fy, axle_r.C, axle_r.E, Fzr, alpha);
Tyr = Fyr * b;

[Tyf1,alphaf1, Tyf2, alphaf2] = brakedown_BCDE(Tyf, alpha);
[Tyr1,alphar1, Tyr2, alphar2] = brakedown_BCDE(Tyr, alpha);

ay = [linspace(0,12,8001)];
Ty = ay * m/2 * l / 2;

alphaf1_interp = interp1(Tyf1,alphaf1,Ty);
if (Tyf2)
    alphaf2_interp = interp1(Tyf2,alphaf2,Ty);
else
    alphaf2_interp = NaN.*Ty;
end

alphar1_interp = interp1(Tyr1,alphar1,Ty);
if (Tyr2)
    alphar2_interp = interp1(Tyr2,alphar2,Ty);
else
    alphar2_interp = NaN.*Ty;
end

handling(:,1) = -(alphaf1_interp - alphar1_interp);
handling(:,2) = -(alphaf1_interp - alphar2_interp);
handling(:,3) = -(alphaf2_interp - alphar1_interp);
handling(:,4) = -(alphaf2_interp - alphar2_interp);

alpha1 = -[alphaf1_interp; alphar1_interp];
alpha2 = -[alphaf2_interp; alphar2_interp];


ay_handle = -ay;
x_handle = -handling;
end