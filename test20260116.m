clc
clear
close all;

veh_1.a = 0.7;
veh_1.l = 1.4;
veh_1.m = 2000;
veh_1.Izz = 120;

veh_2.a = 0.7;
veh_2.l = 1.4;
veh_2.m = 2000;
veh_2.Izz = 120;

tire_A.mu = 1;
tire_A.c1 = 60000;
tire_A.c2 = 4000;
tire_A.C = 1.3;
tire_A.E = -3;

tire_B.mu = 1;
tire_B.c1 = 40000;
tire_B.c2 = 4000;
tire_B.C = 1.3;
tire_B.E = -3;

veh_1.fz_front = 9.8 * veh_1.m * (veh_1.l - veh_1.a) / veh_1.l;
veh_1.fz_rear = 9.8 * veh_1.m * (veh_1.a) / veh_1.l;

veh_2.fz_front = 9.8 * veh_2.m * (veh_2.l - veh_2.a) / veh_2.l;
veh_2.fz_rear = 9.8 * veh_2.m * (veh_2.a) / veh_2.l;

fz = 9.8 * veh_1.m * (veh_1.l - veh_1.a) / veh_1.l;

alpha_test = deg2rad(1) * linspace(0,20,25);
figure
fy_A = magicBCDE(tire_A.mu, tire_A.c1, tire_A.c2, tire_A.C, tire_A.E, alpha_test, fz);
fy_B = magicBCDE(tire_B.mu, tire_B.c1, tire_B.c2, tire_B.C, tire_B.E, alpha_test, fz);
plot(alpha_test, fy_A);hold on
plot(alpha_test, fy_B);

%% Axle Charc. Generation 
% front axle BCDE
[veh_1.raw_data.front.alpha, veh_1.raw_data.front.Fy] = axleCal(veh_1, tire_A, "front", 1200, 330, 1,40);
veh_1.front = fitBCDE(veh_1.raw_data.front.alpha, veh_1.raw_data.front.Fy, veh_1.fz_front);

% rear axle BCDE
[veh_1.raw_data.rear.alpha, veh_1.raw_data.rear.Fy] = axleCal(veh_1, tire_A, "rear", 1200, 330, 1,40);
veh_1.rear = fitBCDE(veh_1.raw_data.rear.alpha, veh_1.raw_data.rear.Fy, veh_2.fz_rear);

% front axle BCDE
[veh_2.raw_data.front.alpha, veh_2.raw_data.front.Fy] = axleCal(veh_2, tire_A, "front", 1200, 330, 1,40);
veh_2.front = fitBCDE(veh_2.raw_data.front.alpha, veh_2.raw_data.front.Fy, veh_2.fz_front);

% rear axle BCDE
[veh_2.raw_data.rear.alpha, veh_2.raw_data.rear.Fy] = axleCal(veh_2, tire_B, "rear", 1200, 330, 1,40);
veh_2.rear = fitBCDE(veh_2.raw_data.rear.alpha, veh_2.raw_data.rear.Fy, veh_2.fz_rear);

%% YMD
delta = deg2rad( linspace( -20, 20, 17 ) );
beta = deg2rad( linspace( -15, 15, 17 ) );


[veh_1.YM.FY12, veh_1.YM.MZ12] = ymdGen(veh_1, delta, beta, 12);
[veh_2.YM.FY12, veh_2.YM.MZ12] = ymdGen(veh_2, delta, beta, 12);

%%
[p1,p2] = ymdPlot(veh_1, veh_1.YM.FY12, veh_1.YM.MZ12, delta, beta, 12, 'Vehicle 1', 1);
legend([p1, p2]);
[p3,p4] = ymdPlot(veh_2, veh_2.YM.FY12, veh_2.YM.MZ12, delta, beta, 12, 'Vehicle 2', 2);
legend([p1,p2,p3, p4]);

%% Handling Curve
[veh_1.handling_curve.handle, veh_1.handling_curve.x, veh_1.handling_curve.alpha1, veh_1.handling_curve.alpha2]...
    = handlingCurve(veh_1);
[veh_2.handling_curve.handle, veh_2.handling_curve.x, veh_2.handling_curve.alpha1, veh_2.handling_curve.alpha2]...
    = handlingCurve(veh_2);


testing_vel = 12;
handlingPlot(veh_1, testing_vel, 1);
handlingPlot(veh_2, testing_vel, 2);