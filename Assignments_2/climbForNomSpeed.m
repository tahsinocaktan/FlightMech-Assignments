function [V_nominal_climb_jet, V_nominal_climb_turbo_piston] = climbForNomSpeed()

% All necessary constants for climb (jet)
VdCL_1 = 5;  % Climb speed increment below 1500 ft (jet) 5 
VdCL_2 = 10; % Climb speed increment below 3000 ft (jet) 10 
VdCL_3 = 30; % Climb speed increment below 4000 ft (jet) 30 
VdCL_4 = 60; % Climb speed increment below 5000 ft (jet) 60 
VdCL_5 = 80; % Climb speed increment below 6000 ft (jet) 80 
VdCL_6 = 20; % Climb speed increment below 500 ft (turbo/piston)
VdCL_7 = 30; % Climb speed increment below 1000 ft (turbo/piston) 
VdCL_8 = 35; % Climb speed increment below 1500 ft (turbo/piston)

Vstall_TO = 63; % From .opf file (kt)
CVmin = 1.3;
Vcl_1 = 98; %(kt)
Vcl_2 = 93; %(kt)
M_cl = 0.2;

% Initialize altitude and V_nominal arrays
altitude = linspace(0,17500,200);
V_nominal_climb_jet = zeros(size(altitude));
V_nominal_climb_turbo_piston = zeros(size(altitude));


[delta] = arrayfun(@deltaTrans, Vcl_2*0.5144, M_cl); 
[theta] = arrayfun(@thetaTrans, delta); 
%[Mach_grid, VCAS_grid] = meshgrid(Mach_range, VCAS_range);
Hp_climb = arrayfun(@transitionAltitude, theta);

% Calculate V_nominal_climb_jet for each altitude
for i = 1:length(altitude)
    if (altitude(i) <= 1499)
        V_nominal_climb_jet(i) = CVmin * Vstall_TO + VdCL_1;
    elseif (altitude(i) <= 2999)
        V_nominal_climb_jet(i) = CVmin * Vstall_TO + VdCL_2;
    elseif (altitude(i) <= 3999)
        V_nominal_climb_jet(i) = CVmin * Vstall_TO + VdCL_3;
    elseif (altitude(i) <= 4999)
        V_nominal_climb_jet(i) = CVmin * Vstall_TO + VdCL_4;
    elseif (altitude(i) <= 5999)
        V_nominal_climb_jet(i) = CVmin * Vstall_TO + VdCL_5;
    elseif (altitude(i) <= 9999)
        V_nominal_climb_jet(i) = min(Vcl_1, 250);
    elseif (altitude(i) <= Hp_climb)
        V_nominal_climb_jet(i) = Vcl_2;
    else 
        V_nominal_climb_jet(i) = M_cl*((1.4*287.05287*(288.15-10-(0.0065*altitude))).^(1/2));
    end
end
% Calculate V_nominal_climb_turbo_piston for each altitude
for i = 1:length(altitude)
    if (altitude(i) <= 499)
        V_nominal_climb_turbo_piston(i) = CVmin * Vstall_TO + VdCL_6;
    elseif (altitude(i) <= 999)
        V_nominal_climb_turbo_piston(i) = CVmin * Vstall_TO + VdCL_7;
    elseif (altitude(i) <= 1499)
        V_nominal_climb_turbo_piston(i) = CVmin * Vstall_TO + VdCL_8;
    elseif (altitude(i) <= 9999)
        V_nominal_climb_turbo_piston(i) = min(Vcl_1, 250);
    elseif (altitude(i) <= Hp_climb)
        V_nominal_climb_turbo_piston(i) = Vcl_2;
    else 
        V_nominal_climb_turbo_piston(i) = M_cl*((1.4*287.05287*(288.15-10-(0.0065*altitude))).^(1/2));
    end
end
% Plot the graph
figure;
subplot(2,1,1);plot(altitude, V_nominal_climb_jet,'LineWidth', 2);title('Nominal Climb Speed Jet vs. Altitude');
               xlabel('Altitude (ft)');ylabel('Nominal Climb Speed (kt)');grid on;
subplot(2,1,2);plot(altitude, V_nominal_climb_turbo_piston,'LineWidth', 2);title('Nominal Climb Speed Turbo/Piston vs. Altitude');
               xlabel('Altitude (ft)');ylabel('Nominal Climb Speed (kt)');grid on;
end
