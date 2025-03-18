function [p] = pressure(T)

    %Constant
    p0= 101325; % standard pressure at MSL (Pa)
    T0 = 288.15; % standard temperature at MSL (k)
    tempGradient = -0.0065; % ISA temperature gradient with altitude below the tropopause: (K/m)
    g = 9.81; % Acceleration due to gravity (m/s^2)
    R = 287; % Specific gas constant for air (J/kg.K)

    %Pressure at altitude H
    p = p0 * ((T+15)/T0)^-(g/(tempGradient * R));
end

