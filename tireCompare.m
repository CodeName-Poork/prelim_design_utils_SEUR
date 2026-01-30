clc;
clear;
close all;

mapmap = lines;
%%
load('B1965run37.mat');
Conti43329.FY = FY;
Conti43329.SA = SA;
Conti43329.IA = IA;
Conti43329.P = P;

Conti43329.FZ = FZ;
Conti43329.MZ = MZ;
Conti43329.SA = SA;
Conti43329.ET = ET;
Conti43329.V = V;
figure(7200)
plot(IA);hold on;
plot(P);hold on;
plot(FZ./100);hold on;
plot(V);hold on;
%%
load('B2356run32.mat');
Hoosier43100.FY = FY;
Hoosier43100.SA = SA;
Hoosier43100.IA = IA;
Hoosier43100.P = P;
Hoosier43100.FZ = FZ;
Hoosier43100.MZ = MZ;
Hoosier43100.SA = SA;
Hoosier43100.ET = ET;
Hoosier43100.V = V;
figure(7199)
plot(IA);hold on;
plot(P,'-b');hold on;
plot(FZ./100);hold on;
plot(V);hold on;
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
plot(FZ./100);hold on;
plot(V);hold on;


%%
figure(43329)
p1 = plot(Conti43329.SA(22540:27464),Conti43329.FY(22540:27464));hold on;
p2 = plot(Hoosier43100.SA(22417:27393),Hoosier43100.FY(22417:27393));hold on;
p3 = plot(Hoosier43075.SA(22437:27357),Hoosier43075.FY(22437:27357));hold on;
p1.LineWidth = 1;
p2.LineWidth = 1;
p3.LineWidth = 1;
p1.DisplayName = 'Continental 43329 FY'
p2.DisplayName = 'Hoosier 43100 R20 FY'
p3.DisplayName = 'Hoosier 43075 R20 FY'
legend();
xlabel('\alpha (deg)');
ylabel('Fy (N)');
title('FY - Pure Cornering')
figure(43328)
pz1 = plot(Conti43329.SA(22540:27464),Conti43329.MZ(22540:27464));hold on;
pz2 = plot(Hoosier43100.SA(22417:27393),Hoosier43100.MZ(22417:27393));hold on;
pz3 = plot(Hoosier43075.SA(22437:27357),Hoosier43075.MZ(22437:27357));hold on;
pz1.LineWidth = 1;
pz2.LineWidth = 1;
pz3.LineWidth = 1;
pz1.DisplayName = 'Continental 43329 FY'
pz2.DisplayName = 'Hoosier 43100 R20 FY'
pz3.DisplayName = 'Hoosier 43075 R20 FY'
legend();
xlabel('\alpha (deg)');
ylabel('Mz (Nm)');
title('MZ - Pure Cornering')

%%

figure(43332)
plot(Conti43329.SA(22540:27464),Conti43329.FZ(22540:27464));hold on;
plot(Hoosier43100.SA(22417:27393),Hoosier43100.FZ(22417:27393));hold on;
plot(Hoosier43075.SA(22437:27357),Hoosier43075.FZ(22437:27357));hold on;
%%
figure(43330)
I = 22504:27443;
scatter3(Conti43329.SA(I),Conti43329.IA(I),Conti43329.FY(I),'o','MarkerEdgeColor',mapmap(1,:));hold on;
I = 22450:27380;
scatter3(Hoosier43100.SA(I),Hoosier43100.IA(I),Hoosier43100.FY(I),'o','MarkerEdgeColor',mapmap(2,:));hold on;
I = 22706:27408;
scatter3(Hoosier43075.SA(I),Hoosier43075.IA(I),Hoosier43075.FY(I),'o','MarkerEdgeColor',mapmap(3,:));hold on;



I = 28731:33718;
scatter3(Conti43329.SA(I),Conti43329.IA(I),Conti43329.FY(I),'+','MarkerEdgeColor',mapmap(1,:));hold on;
I = 28653:33542;
scatter3(Hoosier43100.SA(I),Hoosier43100.IA(I),Hoosier43100.FY(I),'+','MarkerEdgeColor',mapmap(2,:));hold on;
I = 28738:33631;
scatter3(Hoosier43075.SA(I),Hoosier43075.IA(I),Hoosier43075.FY(I),'+','MarkerEdgeColor',mapmap(3,:));hold on;

I = 34996:39968;
scatter3(Conti43329.SA(I),Conti43329.IA(I),Conti43329.FY(I),'.','MarkerEdgeColor',mapmap(1,:));hold on;
I = 34865:39788;
scatter3(Hoosier43100.SA(I),Hoosier43100.IA(I),Hoosier43100.FY(I),'.','MarkerEdgeColor',mapmap(2,:));hold on;
I = 35523:39869;
scatter3(Hoosier43075.SA(I),Hoosier43075.IA(I),Hoosier43075.FY(I),'.','MarkerEdgeColor',mapmap(3,:));hold on;
%%

%%
figure(43333)
align = -10;
I = 22504:27443;
s11 = scatter(Conti43329.SA(I),Conti43329.FY(I),'o','MarkerEdgeColor',mapmap(1,:));hold on;
I = 22450:27380;
s12 = scatter(Hoosier43100.SA(I),Hoosier43100.FY(I)+align,'o','MarkerEdgeColor',mapmap(2,:));hold on;
I = 22706:27408;
s13 = scatter(Hoosier43075.SA(I),Hoosier43075.FY(I)+align,'o','MarkerEdgeColor',mapmap(3,:));hold on;



I = 28731:33718;
s21 = scatter(Conti43329.SA(I),Conti43329.FY(I),'+','MarkerEdgeColor',mapmap(1,:));hold on;
I = 28653:33542;
s22 = scatter(Hoosier43100.SA(I),Hoosier43100.FY(I)+align,'+','MarkerEdgeColor',mapmap(2,:));hold on;
I = 28738:33631;
s23 = scatter(Hoosier43075.SA(I),Hoosier43075.FY(I)+align,'+','MarkerEdgeColor',mapmap(3,:));hold on;

I = 34996:39968;
s31 = scatter(Conti43329.SA(I),Conti43329.FY(I),'.','MarkerEdgeColor',mapmap(1,:));hold on;
I = 34865:39788;
s32 = scatter(Hoosier43100.SA(I),Hoosier43100.FY(I)+align,'.','MarkerEdgeColor',mapmap(2,:));hold on;
I = 35523:39869;
s33 = scatter(Hoosier43075.SA(I),Hoosier43075.FY(I)+align,'.','MarkerEdgeColor',mapmap(3,:));hold on;
s11.DisplayName = 'Continental 43329 IA = 0'
s12.DisplayName = 'Hoosier 43100 IA = 0'
s13.DisplayName = 'Hoosier 43075 IA = 0'

s21.DisplayName = 'Continental 43329 IA = 2'
s22.DisplayName = 'Hoosier 43100 IA = 2'
s23.DisplayName = 'Hoosier 43075 IA = 2'

s31.DisplayName = 'Continental 43329 IA = 4'
s32.DisplayName = 'Hoosier 43100 IA = 4'
s33.DisplayName = 'Hoosier 43075 IA = 4'
legend();
xlabel('\alpha (deg)');
ylabel('Fy (N)');
title('FY - Inclinated Cornering')

%%
axis([-1 1 -200 200]);
grid on;