H_m = 16000*0.3084; % Altitude converting from 16000 ft to meters
CAS_max = 204*0.514444; % max operating speed CAS m/s
CAS_stall = 68*0.514444; % stall speed CAS m/s

onesMatrix = ones(1,200);

CAS_range = linspace(CAS_stall,CAS_max,200); % Range of CAS values
Mach_range = linspace(0,0.43,200); % Range of Mach numbers



[T] = arrayfun(@temperature, H_m);
[p] = arrayfun(@pressure, T);
[rho] = arrayfun(@density, p, T);
[a] = speed_of_sound(T);

%adjsuting dimesion 
[T] = T.*onesMatrix;
[p] = p.*onesMatrix; 
[rho] = rho.*onesMatrix;
[a] = a.*onesMatrix;

%[V_cas] = arrayfun(@TAS2CAS, p, rho, V_tas_1);
[V_tas_1] = arrayfun(@CAS2TAS, p, rho, CAS_range);
[V_tas_2] = arrayfun(@Mach2TAS, a, Mach_range);


figure;
subplot(2,1,1); plot(V_tas_1, CAS_range); title('V_tas-V_cas graph'); xlabel('V_tas(m/s)'); ylabel('V_cas(m/s)');
subplot(2,1,2); plot(V_tas_2, Mach_range); title('V_tas-Mach graph'); xlabel('V_tas'); ylabel('Mach Number');
