clc;
clear;
close all;

mapmap = lines;

%%
load('B2356run6.mat');
Hoosier43075.FY = FY;
Hoosier43075.SA = SA;
Hoosier43075.IA = IA;
Hoosier43075.P = P;
Hoosier43075.FZ = FZ;
Hoosier43075.MZ = MZ;
Hoosier43075.SA = SA;
Hoosier43075.ET = ET;
Hoosier43075.V = V;

figure(7198)
plot(IA);hold on;
plot(P);hold on;
plot(FZ./1000);hold on;
plot(V);hold on;
legend('IA','P','FZ','V');
grid on;

pure_lat_54kph = [1:7272];
pure_lat_80kph = [22437:27357];
pure_lat = [pure_lat_54kph, pure_lat_80kph];
%%
figure(43329)
p3 = plot(Hoosier43075.SA(pure_lat_54kph),Hoosier43075.FY(pure_lat_54kph));hold on;
p4 = plot(Hoosier43075.SA(pure_lat_80kph),Hoosier43075.FY(pure_lat_80kph));hold on;
p3.LineWidth = 1;
p4.LineWidth = 1;
p3.DisplayName = 'Hoosier 43075 R20 FY (54kph)';
p4.DisplayName = 'Hoosier 43075 R20 FY (80kph)';
legend();

xlabel('\alpha (deg)');
ylabel('Fy (N)');
title('FY - Pure Cornering');

grid on;

figure(43330);plotbrowser
p3 = plot3(-Hoosier43075.FZ(pure_lat_54kph),-Hoosier43075.SA(pure_lat_54kph),Hoosier43075.FY(pure_lat_54kph));hold on;
p4 = plot3(-Hoosier43075.FZ(pure_lat_80kph),-Hoosier43075.SA(pure_lat_80kph),Hoosier43075.FY(pure_lat_80kph));hold on;
p3.LineWidth = 1;
p4.LineWidth = 1;
p3.DisplayName = 'Hoosier 43075 R20 FY (54kph)';
p4.DisplayName = 'Hoosier 43075 R20 FY (80kph)';
legend();

xlabel('Fy [N]');
ylabel('\alpha [deg]');
zlabel('Fy [N]');
title('FY - Pure Cornering');
grid on;

%%
fz_data = - Hoosier43075.FZ(pure_lat);
alpha_data = - deg2rad(1) * Hoosier43075.SA(pure_lat);
fy_data = Hoosier43075.FY(pure_lat);

tire_43075_raw = fitBCDE_2d(alpha_data, fy_data, fz_data);
alpha_grid_1d = deg2rad(linspace(-20,20,40));
fz_grid_1d = linspace(0,1600,40);

[fz_grid, alpha_grid] = meshgrid(fz_grid_1d, alpha_grid_1d);

fy_out_raw = magicBCDE(tire_43075_raw.mu, tire_43075_raw.c1, tire_43075_raw.c2, tire_43075_raw.C, tire_43075_raw.E, alpha_grid, fz_grid);
figure(43330);plotbrowser
ms = mesh(fz_grid, rad2deg(1)* alpha_grid,fy_out_raw);
ms.FaceAlpha = 0;
ms.EdgeColor = [0.5,0.5,0.5];
ms.DisplayName = 'Raw'

%%
tire_43075.mu = tire_43075_raw.mu * 0.5;
tire_43075.c1 = tire_43075_raw.c1 * 1;
tire_43075.c2 = tire_43075_raw.c2 * 1;
tire_43075.C  = tire_43075_raw.C  * 1;
tire_43075.E  = tire_43075_raw.E  * 1;
fy_out = magicBCDE(tire_43075.mu, tire_43075.c1, tire_43075.c2, tire_43075.C, tire_43075.E, alpha_grid, fz_grid);
figure(43330);plotbrowser
ms = mesh(fz_grid, rad2deg(1)* alpha_grid,fy_out);
ms.FaceAlpha = 0.2;
ms.FaceColor = [0.7,0.9,0.8];
ms.EdgeColor = [0.2,0.5,0.1];
ms.DisplayName = 'Scaled'