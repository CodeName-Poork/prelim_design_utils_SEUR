function [fyout] = magicBCDE (mu, cfa, C, E, alfin, fzin)
    D = mu .* fzin;
    B = fzin .* cfa ./ D ./ C;
    fyout = D .* sin(C*atan(B .* alfin -  ...
         E .* (B .* alfin - atan(B .* alfin))));
end