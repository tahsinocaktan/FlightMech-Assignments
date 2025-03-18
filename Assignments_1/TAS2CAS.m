function [V_cas] = TAS2CAS(p, rho V_tas)
%TAS2CAS Summary of this function goes here
%   Detailed explanation goes here
p0= 101325; % Sea level standard pressure (Pa)
rho0 = 1.225; % Sea level standard density (kg/m^3)

k = 1.4; %Adiabatic index of air
m = (k-1)/k; 

% from V_tas to V_cas 
V_cas = sqrt((2*p0)/(m*rho0) * ((1+(p/p0) * ((((1 + ((m * rho * V_tas^2)/(2*p)))^(1/m))-1))^m)-1));

end

