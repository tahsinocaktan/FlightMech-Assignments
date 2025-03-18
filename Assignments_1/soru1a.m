% Plotting
H = 0:100:11000; % Altitude range from 0 to 11000 meters
[T] = arrayfun(@temperature, H); 
[p] = arrayfun(@pressure, T);
[rho] = arrayfun(@density, p, T);
[a] = arrayfun(@speed_of_sound, T);


figure;
subplot(2,2,1); plot(H, T); title('H-T graph'); xlabel('H(m)'); ylabel('T(k)');
subplot(2,2,2); plot(H, p); title('H-p graph'); xlabel('H(m)'); ylabel('p(pa)');
subplot(2,2,3); plot(H, rho); title('H-ρ graph'); xlabel('H(m)'); ylabel('ρ(kg/m^3)');
subplot(2,2,4); plot(H, a); title('H-a graph'); xlabel('H(m)'); ylabel('a(m/s)');