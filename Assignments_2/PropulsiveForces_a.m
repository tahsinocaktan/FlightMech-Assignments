CAS_max = 204; % max operating speed CAS kt
CAS_stall = 68; % stall speed CAS kt

% Altitude ve uçuş hızı değerlerini oluştur
Hp_values = linspace(0, 17500, 200);

[V_nominal_climb_jet, V_nominal_climb_turbo_piston] = climbForNomSpeed();


[T] = arrayfun(@temperature, Hp_values.*0.3048); %altitude: m
[p] = arrayfun(@pressure, T);
[rho] = arrayfun(@density, p, T);
[a] = speed_of_sound(T);

%calculation for Vtas
V_nominal_climb_jet_tas = arrayfun(@CAS2TAS, p, rho, V_nominal_climb_jet*0.5144); %m/s
V_nominal_climb_turbo_piston_tas = arrayfun(@CAS2TAS, p, rho, V_nominal_climb_turbo_piston*0.5144); %m/s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Tırmanma itme kuvveti hesapla
[ThrMaxJet_c, ThrMaxTurbo_c, ThrMaxPiston_c] = climbThrust(Hp_values, V_nominal_climb_turbo_piston_tas*1.944012);%kt


% ClimbThrust için grafikler
figure;
subplot(2,2,1); plot(Hp_values, ThrMaxJet_c, 'r'); xlabel('Hp (ft)'); ylabel('ThrMaxJet_c (N)'); grid on;
subplot(2,2,2); plot(Hp_values, ThrMaxTurbo_c, 'g'); xlabel('Hp (ft)'); ylabel('ThrMaxTurbo_c (N)'); grid on;
subplot(2,2,3); plot(Hp_values, ThrMaxPiston_c, 'b'); xlabel('Hp (ft)'); ylabel('ThrMaxPiston_c (N)'); grid on;




