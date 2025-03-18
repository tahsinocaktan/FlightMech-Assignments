function [theta] = thetaTrans(delta)

g0 = 9.80665; %Gravitational acceleration
R = 287.05287; %Real gas constant for air
B = - 0.0065; %ISA temperature gradient with altitude below the tropopause

theta = (delta)^(-B*R/g0);

end



