function [fyout] = magicBCDE (mu, c1, c2, C, E, alfin, fzin)
    D = mu .* fzin;
    Cfa = c1 .*sin(2 * atan(fzin./c2));
    B =  Cfa ./ D ./ C;
    fyout = D .* sin(C*atan(B .* alfin -  ...
         E .* (B .* alfin - atan(B .* alfin))));
end