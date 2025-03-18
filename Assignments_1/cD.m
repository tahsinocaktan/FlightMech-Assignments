function [CD] = cD(cL)
    
    % Constants for drag polar
    CD0 = 0.010058; % CD0 at aircraft.opf file
    k = 1.0290; % from bada ref manual

    CD = CD0 + k .* cL.^2;
end

