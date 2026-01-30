%%
clc
clear
close all
%% vehicle definition
veh_1.a = 0.6;
veh_1.l = 1.4;
veh_1.m = 1500;

veh_1.front.mu = 1;
veh_1.front.c1 = 60000;
veh_1.front.c2 = 4000;
veh_1.front.C = 1.3;
veh_1.front.E = -3;

veh_1.rear.mu = 0.8;
veh_1.rear.c1 = 50000;
veh_1.rear.c2 = 4000;
veh_1.rear.C = 1.2;
veh_1.rear.E = -3;

%%
delta = deg2rad( linspace( -12, 12, 17 ));
beta = deg2rad( linspace( -12, 12, 17 ));


[veh_1.FY12, veh_1.MZ12] = ymdGen(veh_1, delta, beta, 12);
%%
[p1,p2] = ymdPlot(veh_1.FY12, veh_1.MZ12, delta, beta, 12, 'Vehicle 1');
legend([p1, p2]);