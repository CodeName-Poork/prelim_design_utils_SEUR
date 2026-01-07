clc
clear

[alp, dfz, fy] = meshgrid(0:deg2rad(20/100):deg2rad(20), 0:40:4000, 0:80:8000);

f = 1.* (4000 + dfz) .* sin(1.3.* atan( ( 60000 .* sin( 2 .* atan ( (4000 + dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 + dfz) ) ) .* alp - ...
    (-3)*( (60000 .* sin( 2 .* atan ((4000 + dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 + dfz) ) ) .* alp - ...
    atan( (60000 .* sin( 2 .* atan ((4000 + dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 + dfz) ) ) .* alp ) ) ) ) + ...
    1.* (4000 - dfz) .* sin(1.3.* atan( ( 60000 .* sin( 2 .* atan ( (4000 - dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 - dfz) ) ) .* alp - ...
    (-3)*( (60000 .* sin( 2 .* atan ((4000 - dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 - dfz) ) ) .* alp - ...
    atan( (60000 .* sin( 2 .* atan ((4000 - dfz) ./ 4000 ) ) ./ ( 1.3 .* 1 .* (4000 - dfz) ) ) .* alp ) ) ) )...
    - fy ;% 此为随着载荷转移的侧向力


figure(2)
contourslice(alp, dfz, fy, f, [deg2rad(linspace(0,20,100))], [linspace(0,8000,100)], [], [0 0]);
p = isosurface(alp, dfz, fy, f, 0);  

[x, y] = meshgrid(0:deg2rad(20/100):deg2rad(20), 0:80:8000);
fyi = y/0.52;
dfzi = y;
alpi = x;
view(-45, 45);

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

function [fyout] = magic2d (alpin, fzin)
fyout = 1.* fzin .* sin(1.3.* atan( ( 60000 .* sin( 2 .* atan ( fzin ./ 4000 ) ) ./ ( 1.3 .* 1 .* fzin ) ) .* alpin - ...
    (-3)*( (60000 .* sin( 2 .* atan (fzin ./ 4000 ) ) ./ ( 1.3 .* 1 .* fzin ) ) .* alpin - ...
    atan( (60000 .* sin( 2 .* atan (fzin ./ 4000 ) ) ./ ( 1.3 .* 1 .* fzin ) ) .* alpin ) ) ) );
end