clc
clear


tire_A.mu = 1.48;
tire_A.cfa = 32;
tire_A.C = 1.9;
tire_A.E = 0.6;

veh_1.a = 0.6;
veh_1.l = 1.4;
veh_1.m = 300;

%veh_1.front.axle_data = 
axle_cal(veh_1, tire_A, deg2rad(20), 'front');






function axle_cal(veh, tire, alpha_cap, which_axle)
if which_axle == "front" || which_axle == 0
    Fz_norm = 9.8 * veh.m * (veh.l - veh.a) / veh.l;
elseif which_axle == "rear" || which_axle ==1
    Fz_norm = 9.8 * veh.m * veh.a / veh.l;
end

alpha = linspace(0,alpha_cap,20);
delta_Fz = linspace(0,Fz_norm/2,20);
Fy_space = linspace(0,Fz_norm*3,20);

[alpha_2d,delta_Fz_2d] = meshgrid(alpha,delta_Fz);
Fy_2d = magicBCDE(tire.mu, tire.cfa, tire.C, tire.E, alpha_2d, Fz_norm/2 + delta_Fz_2d) + ...
    magicBCDE(tire.mu, tire.cfa, tire.C, tire.E, alpha_2d, Fz_norm/2 - delta_Fz_2d);
mesh(Fy_2d)


[alpha_3d, delta_Fz_3d, Fy_3d] = meshgrid(alpha, delta_Fz, Fy_space);
F = magicBCDE(tire.mu, tire.cfa, tire.C, tire.E, alpha_3d, Fz_norm/2 + delta_Fz_3d) + ...
    magicBCDE(tire.mu, tire.cfa, tire.C, tire.E, alpha_3d, Fz_norm/2 - delta_Fz_3d) %- Fy_3d;



Fy_i = delta_Fz_2d/2;

slice = contourslice(alpha_3d, delta_Fz_3d, Fy_space, F, alpha_2d , delta_Fz_2d , Fy_i, [0 0]);





end



function dontcallme()
[alp, dfz, fy] = meshgrid(linespace(0,alpha_cap,20), 0:40:4000, 0:80:8000);

f = 1.* (4000 + dfz) .* sin(1.3.* atan( ( 60000 .* sin( 2 .* atan ( (4000 + dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 + dfz) ) ) .* alp - ...
    (-3)*( (60000 .* sin( 2 .* atan ((4000 + dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 + dfz) ) ) .* alp - ...
    atan( (60000 .* sin( 2 .* atan ((4000 + dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 + dfz) ) ) .* alp ) ) ) ) + ...
    1.* (4000 - dfz) .* sin(1.3.* atan( ( 60000 .* sin( 2 .* atan ( (4000 - dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 - dfz) ) ) .* alp - ...
    (-3)*( (60000 .* sin( 2 .* atan ((4000 - dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 - dfz) ) ) .* alp - ...
    atan( (60000 .* sin( 2 .* atan ((4000 - dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 - dfz) ) ) .* alp ) ) ) )...
    - fy ;


% magicBCDE (mu, cfa, C, E, alfin, fzin)

% figure(2)
% range = contourslice(alp, dfz, fy, f, [deg2rad(linspace(0,20,100))], [linspace(0,8000,100)], [], [0 0]);
p = isosurface(alp, dfz, fy, f, 0);  
% 
% [x, y] = meshgrid(0:deg2rad(20/100):deg2rad(20), 0:80:8000);
% fyi = y/0.52;
% dfzi = y;
% alpi = x;
% view(-45, 45);

figure(3)
patch(p, 'EdgeColor', 'y', 'FaceColor', 'y', 'FaceAlpha', 0.3);  % 绘制椭球面
bbb = contourslice(alp, dfz, fy, f, alpi, dfzi, fyi, [0 0]);
set(bbb, 'EdgeColor', 'b', 'LineWidth', 2);
view(-45, 45);

projX = bbb.XData;
projY = bbb.YData;

hold on;
plot3(projX, projY, zeros(105));

[alp, fz, fy] = meshgrid(0:deg2rad(20/100):deg2rad(20), 0:80:8000, 0:80:8000);
fmagic = 1.* fz .* sin(1.3.* atan( ( 60000 .* sin( 2 .* atan ( fz ./ 4000 ) ) ./ ( 1.3 .* 1 .* fz ) ) .* alp - ...
    (-3)*( (60000 .* sin( 2 .* atan (fz ./ 4000 ) ) ./ ( 1.3 .* 1 .* fz ) ) .* alp - ...
    atan( (60000 .* sin( 2 .* atan (fz ./ 4000 ) ) ./ ( 1.3 .* 1 .* fz ) ) .* alp ) ) ) )- fy ;


figure(1)
contourslice(alp, fz, fy, fmagic, deg2rad(linspace(0,20,100)), linspace(0,8000,100), [], [0 0]);
fy1 = magic2d(projX, 4000 + projY);
fy2 = magic2d(projX, 4000 - projY);
hold on; plot3(projX, 4000 + projY, fy1); 
hold on; plot3(projX, 4000 - projY, fy2);
hold on; plot3(projX, 4000 - projY + projY , fy2+fy1);
view(-45, 45);
 
figure(3)
hold on; plot3(projX, 0 - projY + projY , fy2+fy1);
view(-45, 45);
end
