function [] = descentForNomSpeed()

% All necessary constants for descent (jet)
VdDES_1 = 5;  % Descent speed increment below 1000 ft (jet/turboprop) 
VdDES_2 = 10; % Descent speed increment below 1500 ft (jet/turboprop)  
VdDES_3 = 20; % Descent speed increment below 2000 ft (jet/turboprop)  
VdDES_4 = 50; % Descent speed increment below 3000 ft (jet/turboprop)  
VdDES_5 = 5;  % Descent speed increment below 500 ft (piston)
VdDES_6 = 10; % Descent speed increment below 1000 ft (piston)
VdDES_7 = 20; % Descent speed increment below 1500 ft (piston) 
Vstall_LD = 59; % From .opf file (kt)
Vdes_1 = 178; % kt
Vdes_2 = 178; % kt
CVmin = 1.3;
M_des = 0.28;


% Initialize altitude and V_nominal_decent arrays
altitude = 0:17500;
V_nominal_decent_jet_turbo = zeros(size(altitude));
V_nominal_decent_piston = zeros(size(altitude));

[delta] = arrayfun(@deltaTrans, Vdes_2*0.5144, M_des); 
[theta] = arrayfun(@thetaTrans, delta); 
Hp_descent = arrayfun(@transitionAltitude, theta);

% Calculate V_nominal_decent_jet_turbo for each altitude
for i = 1:length(altitude)
    if (altitude(i) <= 999)
        V_nominal_decent_jet_turbo(i) = CVmin * Vstall_LD + VdDES_1;
    elseif (altitude(i) <= 1499)
        V_nominal_decent_jet_turbo(i) = CVmin * Vstall_LD + VdDES_2;
    elseif (altitude(i) <= 1999)
        V_nominal_decent_jet_turbo(i) = CVmin * Vstall_LD + VdDES_3;
    elseif (altitude(i) <= 2999)
        V_nominal_decent_jet_turbo(i) = CVmin * Vstall_LD + VdDES_4;
    elseif (altitude(i) <= 5999)
        V_nominal_decent_jet_turbo(i) = min(Vdes_1, 220);
    elseif (altitude(i) <= 9999)
        V_nominal_decent_jet_turbo(i) = min(Vdes_1, 250);
    elseif (altitude(i) <= Hp_descent)
        V_nominal_decent_jet_turbo(i) = Vdes_2;
    else
        V_nominal_decent_jet_turbo(i) = M_des.*((1.4*287.05287*(288.15-10-(0.0065*altitude(i)))).^(1/2));        
    end
end

% Calculate V_nominal_decent_piston for each altitude
for i = 1:length(altitude)
    if (altitude(i) <= 499)
        V_nominal_decent_piston(i) = CVmin * Vstall_LD + VdDES_5;
    elseif (altitude(i) <= 999)
        V_nominal_decent_piston(i) = CVmin * Vstall_LD + VdDES_6;
    elseif (altitude(i) <= 1499)
        V_nominal_decent_piston(i) = CVmin * Vstall_LD + VdDES_7;
    elseif (altitude(i) <= 9999)
        V_nominal_decent_piston(i) = Vdes_1;
    elseif (altitude(i) <= Hp_descent)
        V_nominal_decent_jet_turbo(i) = Vdes_2;
    else
        V_nominal_decent_jet_turbo(i) = M_des.*((1.4*287.05287*(288.15-10-(0.0065*altitude(i)))).^(1/2));        
    end
end

% Plot the graph
figure;
subplot(2,1,1); plot(altitude, V_nominal_decent_jet_turbo, 'LineWidth', 2); title('Nominal Descent Speed Jet/Turbo vs. Altitude'); 
                xlabel('Altitude (ft)'); ylabel('Nominal Descent Speed (kt)'); grid on;
subplot(2,1,2); plot(altitude, V_nominal_decent_piston, 'LineWidth', 2); title('Nominal Descent Speed Piston vs. Altitude'); 
                xlabel('Altitude (ft)'); ylabel('Nominal Descent Speed (kt)'); grid on;

end

