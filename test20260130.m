clc
clear
close all;

veh_1.a = 0.78;
veh_1.l = 1.58;
veh_1.m = 320;
veh_1.Izz = 120;

veh_2.a = 0.86;
veh_2.l = 1.58;
veh_2.m = 320;
veh_2.Izz = 120;

tire_43075.mu = 1.3143;
tire_43075.c1 = 2.9583e+04;
tire_43075.c2 = 779.5220;
tire_43075.C =  1.45;
tire_43075.E = -0.3051;

veh_1.fz_front = 9.8 * veh_1.m * (veh_1.l - veh_1.a) / veh_1.l;
veh_1.fz_rear = 9.8 * veh_1.m * (veh_1.a) / veh_1.l;

veh_2.fz_front = 9.8 * veh_2.m * (veh_2.l - veh_2.a) / veh_2.l;
veh_2.fz_rear = 9.8 * veh_2.m * (veh_2.a) / veh_2.l;

fz = 9.8 * veh_1.m * (veh_1.l - veh_1.a) / veh_1.l;

alpha_test = deg2rad(1) * linspace(0,20,25);


%% Axle Charc. Generation 
% front axle BCDE
[veh_1.raw_data.front.alpha, veh_1.raw_data.front.Fy] = axleCal(veh_1, tire_43075, "front", 1200, 330, 1,40);
veh_1.front = fitBCDE(veh_1.raw_data.front.alpha, veh_1.raw_data.front.Fy, veh_1.fz_front);

% rear axle BCDE
[veh_1.raw_data.rear.alpha, veh_1.raw_data.rear.Fy] = axleCal(veh_1, tire_43075, "rear", 1200, 270, 1,40);
veh_1.rear = fitBCDE(veh_1.raw_data.rear.alpha, veh_1.raw_data.rear.Fy, veh_2.fz_rear);

% front axle BCDE
[veh_2.raw_data.front.alpha, veh_2.raw_data.front.Fy] = axleCal(veh_2, tire_43075, "front", 1200, 330, 1,40);
veh_2.front = fitBCDE(veh_2.raw_data.front.alpha, veh_2.raw_data.front.Fy, veh_2.fz_front);

% rear axle BCDE
[veh_2.raw_data.rear.alpha, veh_2.raw_data.rear.Fy] = axleCal(veh_2, tire_43075, "rear", 1200, 270, 1,40);
veh_2.rear = fitBCDE(veh_2.raw_data.rear.alpha, veh_2.raw_data.rear.Fy, veh_2.fz_rear);

%% YMD
delta = deg2rad( linspace( -10, 10, 31 ) );
beta = deg2rad( linspace( -3.6, 3.6, 31 ) );


[veh_1.YM.FY12, veh_1.YM.MZ12] = ymdGen(veh_1, delta, beta, 12);
[veh_2.YM.FY12, veh_2.YM.MZ12] = ymdGen(veh_2, delta, beta, 12);


%%
[p1,p2] = ymdPlot(veh_1, veh_1.YM.FY12, veh_1.YM.MZ12, delta, beta, 12, 'Vehicle 1', 1);
legend([p1, p2]);
[p3,p4] = ymdPlot(veh_2, veh_2.YM.FY12, veh_2.YM.MZ12, delta, beta, 12, 'Vehicle 2', 2);
legend([p1,p2,p3, p4]);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
box on;

grid on;
grid minor;
ax.GridLineStyle = ':';
ax.GridAlpha = 0.7;

%% Handling Curve
[veh_1.handling_curve.handle, veh_1.handling_curve.x, veh_1.handling_curve.alpha1, veh_1.handling_curve.alpha2]...
    = handlingCurve(veh_1);
[veh_2.handling_curve.handle, veh_2.handling_curve.x, veh_2.handling_curve.alpha1, veh_2.handling_curve.alpha2]...
    = handlingCurve(veh_2);


testing_vel = 12;
handlingPlot(veh_1, testing_vel, 1);
handlingPlot(veh_2, testing_vel, 2);