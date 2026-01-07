clc
clear

%% vehicle definition
veh_1.a = 0.6;
veh_1.l = 1.4;
veh_1.m = 300;

veh_1.front.mu = 1.48;
veh_1.front.cfa = 32;
veh_1.front.C = 1.9;
veh_1.front.E = 0.6;

veh_1.rear.mu = 1.48;
veh_1.rear.cfa = 32;
veh_1.rear.C = 1.9;
veh_1.rear.E = 0.6;

%%
delta = deg2rad( linspace( -10, 10, 17 ) );
beta = deg2rad( linspace( -5, 5, 17 ) );


[veh_1.FY12, veh_1.MZ12] = ymdGen(veh_1, delta, beta, 12);
%%
[p1,p2] = ymdPlot(veh_1.FY12, veh_1.MZ12, delta, beta, 12, 'Vehicle 1');
legend([p1, p2]);