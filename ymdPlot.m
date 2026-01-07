function [p11,p12] = ymdPlot(FY, MZ, delta, beta, Vx, test_name)

figure(8810)
for i = 1:length(delta)
p11 = plot(FY(i,:),MZ(i,:));hold on;
p11.Color = [1.00,0.41,0.16];
p11.LineWidth = 1;
p11.LineStyle = '-';
end

for i = 1:length(beta)
p12 = plot(FY(:,i),MZ(:,i));hold on;
p12.Color = [1.00,0.41,0.16];
p12.LineWidth = 1;
p12.LineStyle = '--';
end

grid on;
p11.DisplayName = [test_name, ':constant \delta @',num2str(Vx) ,'m/s'];
p12.DisplayName = [test_name, ':constant \beta @',num2str(Vx) ,'m/s'];
