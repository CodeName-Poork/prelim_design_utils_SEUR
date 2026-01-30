function handlingPlot(veh, testing_vel, color_idx)
mapmap = lines;
figure(8808)
p1 = plot(veh.handling_curve.x(:,1).',...
    veh.handling_curve.handle);hold on;
p2 = plot(veh.handling_curve.x(:,3).',...
    veh.handling_curve.handle);hold on;
p1.Color = mapmap(color_idx,:); p1.LineWidth = 1; p1.LineStyle = '-';
p2.Color = mapmap(color_idx,:); p2.LineWidth = 1; p2.LineStyle = ':';
xlabel('[US grad.]<<----- L/R [rad] ----->[OS grad.]');
ylabel('ay [m/s/s]');
grid on;

figure(8812)
subplot(2,2,1)
p1 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,1).'),...
    veh.handling_curve.handle ./ testing_vel );hold on;
p2 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,3).'),...
    veh.handling_curve.handle ./ testing_vel);hold on;
deltanlin = (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,1).');

p1.Color = mapmap(color_idx,:); p1.LineWidth = 1; p1.LineStyle = '-';
p2.Color = mapmap(color_idx,:); p2.LineWidth = 1; p2.LineStyle = ':';
xlabel('RWA [deg]');
ylabel('yawrate [rad/s]');
grid on;

subplot(2,2,2)
p1 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,1).'),...
    veh.handling_curve.handle / testing_vel / testing_vel);hold on;
p2 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,3).'),...
    veh.handling_curve.handle / testing_vel / testing_vel);hold on;

p1.Color = mapmap(color_idx,:); p1.LineWidth = 1; p1.LineStyle = '-';
p2.Color = mapmap(color_idx,:); p2.LineWidth = 1; p2.LineStyle = ':';
xlabel('RWA [deg]');
ylabel('path culvature [1/m]');
grid on;


subplot(2,2,3)
p1 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,1).'),...
    veh.handling_curve.handle);hold on;
p2 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,3).'),...
    veh.handling_curve.handle);hold on;


p1.Color = mapmap(color_idx,:); p1.LineWidth = 1; p1.LineStyle = '-';
p2.Color = mapmap(color_idx,:); p2.LineWidth = 1; p2.LineStyle = ':';
xlabel('RWA [deg]');
ylabel('ay [m/s/s]');
grid on;
% axis([0,10,0,15]);

betanlin1f = -(veh.handling_curve.handle * veh.l /testing_vel /testing_vel - veh.handling_curve.x(:,1).') + veh.handling_curve.alpha1(1,:) + veh.a * veh.handling_curve.handle / testing_vel / testing_vel;
betanlin1r = veh.handling_curve.alpha1(2,:) - (veh.l - veh.a) * veh.handling_curve.handle / testing_vel / testing_vel;

betanlin2f = -(veh.handling_curve.handle * veh.l  /testing_vel  /testing_vel - veh.handling_curve.x(:,3).') + veh.handling_curve.alpha2(1,:) + veh.a * veh.handling_curve.handle / testing_vel / testing_vel;
betanlin2r = veh.handling_curve.alpha1(2,:) + (veh.l - veh.a) * veh.handling_curve.handle / testing_vel / testing_vel;

subplot(2,2,4)
p1 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,1).'),...
    rad2deg(1) * betanlin1f);hold on;
p2 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,1).'),...
    rad2deg(1) * betanlin1r);hold on;

p3 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,3).'),...
    rad2deg(1) * betanlin2f);hold on;
p4 = plot( rad2deg(1) * (veh.handling_curve.handle * veh.l/testing_vel/testing_vel - veh.handling_curve.x(:,3).'),...
    rad2deg(1) * betanlin2r);hold on;

p1.Color = mapmap(color_idx,:); p1.LineWidth = 1; p1.LineStyle = '-';
p2.Color = mapmap(color_idx,:); p2.LineWidth = 1; p2.LineStyle = ':';
p3.Color = mapmap(color_idx,:); p3.LineWidth = 1; p3.LineStyle = '--';
p4.Color = mapmap(color_idx,:); p4.LineWidth = 1; p4.LineStyle = '-.';

xlabel('RWA [deg]');
ylabel('beta [deg]');
grid on;