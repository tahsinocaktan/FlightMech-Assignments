function [] = cruiseForNomSpeed()
% All necessary constants for cruise (jet)
Vcr_1 = 155; 
Vcr_2 = 150;
M_cr = 0.28;

% Initialize altitude and V_nominal_cruise arrays
altitude = 0:17500;
V_nominal_cruise_jet = zeros(size(altitude));
V_nominal_cruise_turbo_piston = zeros(size(altitude));

[delta] = arrayfun(@deltaTrans, Vcr_2*0.5144, M_cr); 
[theta] = arrayfun(@thetaTrans, delta); 
Hp_cruise = arrayfun(@transitionAltitude, theta);
% Calculate V_nominal_cruise_jet for each altitude
for i = 1:length(altitude)
    if (altitude(i) <= 2999)
        V_nominal_cruise_jet(i) = min(Vcr_1, 170);
    elseif (altitude(i) <= 5999)
        V_nominal_cruise_jet(i) = min(Vcr_1, 220);
    elseif (altitude(i) <= 13999)
        V_nominal_cruise_jet(i) = min(Vcr_1, 250);
    elseif (altitude(i) <= Hp_cruise)
        V_nominal_cruise_jet(i) = Vcr_2;
    else
        V_nominal_cruise_jet(i) = M_cr.*((1.4*287.05287*(288.15-10-(0.0065.*altitude(i)))).^(1/2));
    end
end
% Calculate V_nominal_cruise_turbo_piston for each altitude
for i = 1:length(altitude)
    if (altitude(i) <= 2999)
        V_nominal_cruise_turbo_piston(i) = min(Vcr_1, 150);
    elseif (altitude(i) <= 5999)
        V_nominal_cruise_turbo_piston(i) = min(Vcr_1, 180);
    elseif (altitude(i) <= 9999)
        V_nominal_cruise_turbo_piston(i) = min(Vcr_1, 250);
    elseif (altitude(i) <= Hp_cruise)
        V_nominal_cruise_turbo_piston(i) = Vcr_2;
    else
        V_nominal_cruise_turbo_piston(i) = M_cr.*((1.4*287.05287*(288.15-10-(0.0065*altitude(i)))).^(1/2));
    end
end

% Plot the graph
figure;
subplot(2,1,1); plot(altitude, V_nominal_cruise_jet,'LineWidth', 2); title('Nominal Cruise Speed Jet vs. Altitude');
                xlabel('Altitude (ft)'); ylabel('Nominal Cruise Speed (kt)'); grid on;
subplot(2,1,2);plot(altitude, V_nominal_cruise_turbo_piston,'LineWidth', 2);title('Nominal Cruise Speed Turbo/Piston vs. Altitude');
               xlabel('Altitude (ft)');ylabel('Nominal Climb Speed (kt)');grid on;

end

