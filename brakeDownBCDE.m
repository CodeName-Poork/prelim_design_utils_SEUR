function [rise_F, rise_alpha, fall_F, fall_alpha] = brakeDownBCDE(F,alpha)
[peak_F, peak_I] = max(F);
rise_F = F(1:peak_I);
fall_F = F(peak_I+1:length(F));
rise_alpha = alpha(1:peak_I);
fall_alpha = alpha(peak_I+1:length(F));
end
