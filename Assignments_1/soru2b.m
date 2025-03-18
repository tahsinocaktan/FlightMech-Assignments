altitudes = 16000*0.3084; % Altitude converting from 16000 ft to meters
onesMatrix = ones(1,200);

[T] = arrayfun(@temperature, altitudes);
[p] = arrayfun(@pressure, T);
[rho] = arrayfun(@density, p, T);

%adjsuting dimesion 
[T] = T.*onesMatrix;
[p] = p.*onesMatrix; 
[rho] = rho.*onesMatrix;
[a] = a.*onesMatrix;


CL_range = 0:0.01:1.530;
% Calculate CD values
CD_range = cD(CL_range);

% Plot
figure;
plot(CD_range, CL_range);
xlabel('CD');
ylabel('CL');
title('CL vs. CD Graph');

