function [a] = speed_of_sound(T)
    % Constants
    R = 287; % Specific gas constant for air (J/kg.K)
    gamma = 1.4; % Specific heat ratio for air

    % Speed of sound at altitude H
    a = sqrt(gamma * R * T);
end

