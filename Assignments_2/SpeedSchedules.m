function [] = SpeedSchedules(Mach,VCAS_range)

Mach_range = linspace (0.25, 0.35, 100);
VCAS_range = linspace(46.296, 77.16, 100); % 90kt = 46,296 m/s and 150kt = 77,16 m/s


[delta] = arrayfun(@deltaTrans, VCAS_range, Mach_range); 
[theta] = arrayfun(@thetaTrans, delta); 



% Prepare the meshgrid for 3D plotting
[Mach_grid, VCAS_grid] = meshgrid(Mach_range, VCAS_range);
[delta] = arrayfun(@deltaTrans, VCAS_grid, Mach_grid); 
[theta] = arrayfun(@thetaTrans, delta); 
%[Mach_grid, VCAS_grid] = meshgrid(Mach_range, VCAS_range);
altitude_grid = arrayfun(@transitionAltitude, theta);

% 3D Plot
figure;
mesh(Mach_grid, VCAS_grid, altitude_grid);
xlabel('Mach Number');
ylabel('VCAS (m/s)');
zlabel('Altitude (ft)');
title('Mach/CAS Transition Altitude');

end


