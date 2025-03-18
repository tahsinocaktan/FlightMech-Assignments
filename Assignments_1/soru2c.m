% Altitudes
altitudes_1 = 12000*0.3084; % in metre
altitudes_2 = 17000*0.3084; % in metre

S = 13.460; % wing area in m

% Speed range
CAS_max = 204*0.514444; % max operating speed CAS m/s
CAS_stall = 68*0.514444; % stall speed CAS m/s
CAS_range = linspace(CAS_stall,CAS_max,200); % Range of CAS values

% Convert speeds to TAS and calculate drag at alt=12000*0.3084 m
[T_1] = arrayfun(@temperature, altitudes_1);
[p_1] = arrayfun(@pressure, T_1);
[rho_1] = arrayfun(@density, p_1, T_1);

TAS_1 = CAS2TAS(p_1, rho_1, CAS_range); % CAS2TAS function 
CL_1 = cL(rho_1,TAS_1); 
CD_1 = cD(CL_1);

D_range_1 = rho .* TAS_1.^2 .* S .* CD_1.^2 ./ 2; %%expression between D and V 

% Convert speeds to TAS and calculate drag at alt=17000*0.3084 m

[T_2] = arrayfun(@temperature, altitudes_2);
[p_2] = arrayfun(@pressure, T_2);
[rho_2] = arrayfun(@density, p_2, T_2);

TAS_2 = CAS2TAS(p_2, rho_2, CAS_range); % CAS2TAS function 
CL_2 = cL(rho_2,TAS_2); 
CD_2 = cD(CL_2);

D_range_2 = rho_2 .* TAS_2.^2 .* S .* CD_2.^2 ./ 2; %expression between D and V 

% Plot
figure;
plot(TAS_1, D_range_1);
xlabel('Speed (m/s)');
ylabel('Drag');
title(['Drag vs. Speed ']);

hold on
plot(TAS_2, D_range_2);
legend('alt=12000 ft','alt=17000 ft');


