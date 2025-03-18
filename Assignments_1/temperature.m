function [T] = temperature(H)

    %Constant
    T0 = 288.15; % standard temperature at MSL (k)
    tempGradient = -0.0065; % ISA temperature gradient with altitude below the tropopause: (K/m)
    
    % Temperature at altitude H
    T = T0 - 15 + tempGradient * H;

end


