function [FY,MZ] = ymdGen(veh, delta, beta, Vx)

FY = zeros(length(delta), length(beta));
MZ = zeros(length(delta), length(beta));

for i = 1:length(delta)
    for j = 1:length(beta)
        tic
        [FY(i,j),MZ(i,j)] = ymSolve(veh,delta(i),beta(j),Vx);
        toc
    end
end