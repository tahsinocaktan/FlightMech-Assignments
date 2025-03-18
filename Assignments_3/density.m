function [rho] = density(p,T)

    %constant
    R = 287; % Specific gas constant for air (J/kg.K)


    % Air density at altitude H
    rho = p ./ (R .* T);

end

