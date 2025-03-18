function [fcl_jet, fcl_turbo, fcl_piston] = fuelConsumptionf(Hp, ThrMaxJet_c, ThrMaxTurbo_c)

Hp = linspace(0, 17500, 200);

%adjust array size
x = ones(1,200);

%Thrust Specific Fuel Consumption Coefficients from .opf file
Cf_1 =  0.95185;
Cf_2 = 16900;

%Descent Fuel Flow Coefficients from .opf file
Cf_3 = 0.65560;
Cf_4 = 45700;

%Cruise Corr. from .opf file
Cf_cr = 0.73348; 

%for calculation thr

k = 1.029;
cD0 = 0.019;
S = 13.46;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CAS_max = 204; % max operating speed CAS kt
CAS_stall = 68; % stall speed CAS kt

% Altitude ve uçuş hızı değerlerini oluştur
Hp_values = linspace(0, 17500, 200);

CAS_range = linspace(CAS_stall*0.514444,CAS_max*0.514444,200); % Range of CAS values
Mach_range = linspace(0,0.43,200); % Range of Mach numbers

[T] = arrayfun(@temperature, Hp_values.*0.3048); %altitude: m
[p] = arrayfun(@pressure, T);
[rho] = arrayfun(@density, p, T);
[a] = speed_of_sound(T);

%calculation for Vtas
Vtas_values_ms = arrayfun(@CAS2TAS, p, rho, CAS_range); %m/s
Vtas_values = Vtas_values_ms .* 1.944012; 

cL = 280000./(rho.* Vtas_values_ms.^2.*S);
cD = cD0 + k.*cL;
Thr = rho .* Vtas_values_ms.^2 .* S .* cD/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%thrust specific fuel consumption,
n_jet = Cf_1 .* (1 + (Vtas_values/Cf_2)); 
n_turboprop = Cf_1 .* (1 - (Vtas_values/Cf_2)) .* (Vtas_values/1000);


%climb fuel flow
fcl_jet = n_jet .* ThrMaxJet_c;
fcl_turbo = n_turboprop .* ThrMaxTurbo_c;
fcl_piston = Cf_1;
fcl_piston = fcl_piston .* x;

%descent fuel flow
fdes_jet = Cf_3 .* (1 - (Hp/Cf_4));
fdes_turbo = Cf_3 .* (1 - (Hp/Cf_4));
fdes_piston = Cf_3;
fdes_piston = fdes_piston .* x;

%cruise fuel flow
fcr_jet = n_jet .* Thr .* Cf_cr;
fcr_turbo = n_turboprop .* Thr .* Cf_cr;
fcr_piston = Cf_1 .* Cf_cr;
fcr_piston = fcr_piston .* x;

figure;

subplot(3,1,1); plot(Hp_values, fcl_jet, 'r');xlabel('Hp (ft)');ylabel('fcl_jet (kg/min))');
title('climb fuel flow jet');
subplot(3,1,2); plot(Hp_values, fcl_turbo, 'r'); xlabel('Hp (ft)'); ylabel('fcl_turbo (kg/min)');
title('climb fuel flow turboprop');
subplot(3,1,3); plot(Hp_values, fcl_piston, 'r'); xlabel('Hp (ft)'); ylabel('fcl_piston (kg/min)');
title('climb fuel flow piston');

figure;

subplot(3,1,1); plot(Hp_values, fdes_jet, 'r');xlabel('Hp (ft)');ylabel('fdes_jet (kg/min)');
title('descent fuel flow jet');
subplot(3,1,2); plot(Hp_values, fdes_turbo, 'r'); xlabel('Hp (ft)'); ylabel('fdes_turbo (kg/min)');
title('descent fuel flow turboprop');
subplot(3,1,3); plot(Hp_values, fdes_piston, 'r'); xlabel('Hp (ft)'); ylabel('fdes_piston (kg/min)');
title('descent fuel flow piston');


figure;

subplot(3,1,1); plot(Hp_values, fcr_jet, 'r');xlabel('Hp (ft)');ylabel('fcr_jet (kg/min)');
title('cruise fuel flow jet');
subplot(3,1,2); plot(Hp_values, fcr_turbo, 'r'); xlabel('Hp (ft)'); ylabel('fcr_turbo (kg/min)');
title('cruise fuel flow turboprop');
subplot(3,1,3); plot(Hp_values, fcr_piston, 'r'); xlabel('Hp (ft)'); ylabel('fcr_piston (kg/min)');
title('cruise fuel flow piston');

end

