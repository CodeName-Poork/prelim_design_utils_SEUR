function [p11,p12] = ymdPlot(veh, FY, MZ, delta, beta, Vx, test_name, color_idx)
mapmap = lines;
figure(8810)
for i = 1:length(delta)
p11 = plot(FY(i,:)./veh.m, MZ(i,:)./veh.Izz);hold on;
p11.Color = mapmap(color_idx,:);
p11.LineWidth = 1;
p11.LineStyle = '-';
end

for i = 1:length(beta)
p12 = plot(FY(:,i)./veh.m ,MZ(:,i)./veh.Izz);hold on;
p12.Color = mapmap(color_idx,:);
p12.LineWidth = 1;
p12.LineStyle = '--';
end

xlabel('Lateral Acc. [m/s^2]')
ylabel('Yaw Acc. [rad/s^2]')
grid on;

p11.DisplayName = [test_name, ':constant \delta @',num2str(Vx) ,'m/s'];
p12.DisplayName = [test_name, ':constant \beta @',num2str(Vx) ,'m/s'];
