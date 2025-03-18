%******* TAHSİN OCAKTAN *******%
%%%%%%% FLIGHT MECHANICS %%%%%%%
%%%%%%%%% HOMEWORK 3 %%%%%%%%%%%
%* METHOD 3 CONSTANT V and rho *% 

clc;
clear; 

%METHOD 3 CONSTANT V and rho 

%*********adjust constant variable 
h = 4500; %meter
g = 9.80665; %Gravitational acceleration
S= 13.460; %wing area

k = 1.0290; cD0 = 0.019; % from .opf file in bada ref manual
E_max = 1/2*sqrt(k*cD0); % max fines
E_br = 0.866*E_max; %best range fines
c = 0.8;

fuel_mass = 3070; %kg

%*********adjusting iteration 
step_size=1;
t_final= 189;
t= 0:step_size:t_final;

%*********adjusting array size
x1 = zeros(size(t));
x2 = zeros(size(t));
x3 = zeros(size(t));
x4 = zeros(size(t));
x5 = zeros(size(t));
x6 = zeros(size(t));
rho = zeros(size(t));

%*********adjusting initial values
x1(1)=0; 
x2(1)=0;
x3(1)=h; 
x4(1)=0.514444*Vnom_cr(x3(1)*3.2808399); %knot to m/s
x5(1)=0;
x6(1)=1542;
path_angle(1)=0;

for i= 1:t_final
    
    path_angle(i)=0;   
    u2(i)=0;
    
    T(i) = arrayfun(@temperature, x3(1)); %temp func from hw1
    p(i) = arrayfun(@pressure, T(i)); %pressure func from hw1
    rho(i) = arrayfun(@density, p(i), T(i)); %density func from hw1
    
    cL(i) = (2.*(x6(i).*g))./(rho(i).*(x4(1).^2).*S.*(cosd(u2(i)))); %lift coeff
    cD(i) = 0.04339 +  0.040074*(cL(i).^2); %drag coeff
    
    f(i) = fuelcon_cr(x3(i)*3.2808399)/60;  %N/s
    fuel_mass = fuel_mass - f(i); %update fuel mass
    D(i) = (0.5).*rho(i).*(x4(i)^2).*S.*cD(i); %drag force
    
    if fuel_mass > 0 %check the fuel 
    der_x1 = x4(1) .* cosd(x5(i)) .* cosd(path_angle(i));     
    der_x6 = -f(i); 
    u1(i) = D(i); % thrust = drag
    %u2(i) = acos(2*x6(i)*g/(rho(i)*(x4(1))^2*S*cL(i))); %bank angle  
    %der_x5 = -(((cL(i)*S*rho(i)*x4(1))/(2*x6(i)))*sind(u2(i)));
    x1(i+1) = x1(i)+ 1000*der_x1.*step_size; %km to m/s
    x2(i+1) = x2(i); 
    x3(i+1) = x3(i); %constant
    x4(i+1) = x4(i); %constant
    x5(i+1) = x5(i);
    x6(i+1) = x6(i)+ der_x6.*step_size; %decreases
        
    else
        break
        
    end
end

last_weight = x6(189) * g;
delta_W = (x6(1) - x6(189)) * g;

max_rage = x1(189)-x1(1);

subplot(4,2,1); plot3(x1(:),x2(:),x3(:));
grid on
title('3D Position Graph');xlabel('X(m)'); ylabel('Y(m)');zlabel('Z (m)');

subplot(4,2,2); plot(t,x4(:)); 
title('Speed-Time Graph'); xlabel('Time (s)'); ylabel('VTAS (m/s)');

subplot(4,2,3); plot(t,(x4(:).*sind(path_angle)));
title('Vertical Speed-Time Graph'); xlabel('Time (s)'); ylabel('Vertical Speed (m/s)');

subplot(4,2,4); plot(t,x5(:));
title('Heading Angle-Time Graph'); xlabel('Time(s)'); ylabel('Heading Angle (degree)');

subplot(4,2,5); plot(t,x6(:));
title('Mass-Time Graph'); xlabel('Time (s)'); ylabel('Mass (kg)');

subplot(4,2,6); plot(t(1:t_final),u1(:)); 
title('Thrust-Time Graph'); xlabel('Time (s)');ylabel('Thrust (N)');

subplot(4,2,7); plot(t(1:t_final),u2(:));
title('Bank Angle-Time Graph'); xlabel('Time (s)'); ylabel('Bank Angle (degree)');

subplot(4,2,8); plot(t(1:t_final),path_angle); 
title('Flight Path Angle-Time Graph'); xlabel('Time (s)'); ylabel('Flight Path Angle(degree)');
