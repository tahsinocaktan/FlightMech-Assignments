% Constants
VCAS = 90; % VCAS in knots
altitude = 16000; % Altitude in feet


[T] = arrayfun(@temperature, altitude * 0.3048);
[p] = arrayfun(@pressure, T);
[rho] = arrayfun(@density, p, T);


% Convert VCAS to TAS in m/s
TAS = CAS2TAS(p, rho, VCAS * 0.514444); % Convert knots to m/s and feet to meters

% Call CL funciton
CL = cL(rho,TAS)




