function [V_tas] = CAS2TAS(p, rho, V_cas)

%constant
p0= 101325; % standard pressure at MSL(Pa)
rho0 = 1.225; % standard density at MSL(kg/m^3)

k = 1.4; %Adiabatic index of air
m = (k-1)/k;

% from V_cas to V_tas 
V_tas = sqrt((2.*p)/(m.*rho) .* ((1+(p0./p) .* ((((1 + ((m .* rho0 .* V_cas.^2)./(2 * p0))).^(1/m))-1)).^m)-1));

end

