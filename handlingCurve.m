function [ay_handle, x_handle, alpha1, alpha2] = handlingCurve(veh)
l = veh.l;
a = veh.a;
b = l - a;
m = veh.m;

Fzf = m*9.8/l*b; % front wheel load
Fzr = m*9.8/l*a; % rear wheel load
alpha = deg2rad(linspace(0,20,101)); %side slip space

Fyf = magicBCDE(veh.front.mu, veh.front.c1, veh.front.c2, veh.front.C, veh.front.E, alpha, Fzf);
Tyf = Fyf * a;
Fyr = magicBCDE(veh.rear.mu, veh.rear.c1, veh.rear.c2, veh.rear.C, veh.rear.E, alpha, Fzr);
Tyr = Fyr * b;

[Tyf1,alphaf1, Tyf2, alphaf2] = brakeDownBCDE(Tyf, alpha);
[Tyr1,alphar1, Tyr2, alphar2] = brakeDownBCDE(Tyr, alpha);

ay = linspace(0,12,8001);
Ty = ay * m/2 * l / 2;
% f1 and r1 stand for first and second half of the alpha
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

% !!!!!!!!
% The minor sign here is put due to the nature of handling curve is (left -
% right) equals positive. The minor sign appears here and here only.
handling(:,1) = -(alphaf1_interp - alphar1_interp); 
handling(:,2) = -(alphaf1_interp - alphar2_interp);
handling(:,3) = -(alphaf2_interp - alphar1_interp);
handling(:,4) = -(alphaf2_interp - alphar2_interp);

alpha1 = [alphaf1_interp; alphar1_interp];
alpha2 = [alphaf2_interp; alphar2_interp];


ay_handle = ay;
x_handle = handling;
end