function [CL] = cL(rho,TAS)

weight = 1.5420 * 1000; % weight in kg
g = 9.80665; % gravitational acceleration m/s^2
S = 13.460; % wing area in m

CL = 2 .* weight .* g ./ (rho .* TAS.^2 .* S);
end


