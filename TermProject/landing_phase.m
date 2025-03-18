%**************** TAHSİN OCAKTAN ***************%
%%%%%%%%%%%%%%% FLIGHT MECHANICS %%%%%%%%%%%%%%%%
%%%%%%%%% TERM HOMEWORK - LANDING PHASE %%%%%%%%%

clc;
clear;

%*********adjust constant variable
h = 0; % landing altitude in meter
range = 761.05; % target distance
g = 9.80665; % gravitational acceleration
S= 511; % wing area
c = 0.93; % 1/h
m = 0.3; % friction coeff
k = 0.043;
%---------------------------------------------------

%*********adjusting iteration 
step_size = 1;
t_final = 13;
t = 0:step_size:t_final;
%---------------------------------------------------

%*********adjusting array size
ro = zeros(size(t));
x1 = zeros(size(t));
x2 = zeros(size(t));
x3 = zeros(size(t));
x4 = zeros(size(t));
x5 = zeros(size(t));
x6 = zeros(size(t));
u1 = zeros(size(t));
u2 = zeros(size(t));
u3 = zeros(size(t));
%---------------------------------------------------

%*********adjusting initial values
x1(1)=0;  % x position
x2(1)=0;  % y position
x3(1)=h;  % z position
x4(1)=59.61; % v_tas 
x5(1)=0; % heading
x6(1)=152877; %mass
u1(1)=94768.12; %thrust
u2(1)=0; % bank
u3(1)=0; %path

for i= 1:t_final

     u3(i)=0; % path
     u2(i)=0; % bank
     ro(i)=(101325.*(1-x3(1)/44330.8).^5.256)/(287.05287.*(288.15-0.0065.*x3(1)));  % constant density 

     cL(i) = (2.*(x6(i).*g))./(ro(i).*(x4(i).^2).*S.*(cosd(u2(i))));
     cD(i) = 0.028 +  k*(cL(i).^2);
     D(i) = (0.5).*ro(i).*(x4(i)^2).*S.*cD(i);
     L(i) = (0.5).*ro(i).*(x4(i)^2).*S.*cL(i);

     if x1(i) <= range

     u1(i+1)= D(i)+ m*(x6(i)*g - L(i)); % thrust
     f(i) = c.*u1(i)./3600;  %N/s

     %************equation from hw_3
     der_x1= x4(i).*cosd(x5(i)).*cosd(u3(i));
     der_x2= x4(i).*sind(x5(i)).*cosd(u3(i));
     der_x3= x4(i).*sind(u3(i));
     der_x4= -((cD(i)*S.*ro(i)*((x4(i)).^2))/(2*x6(i))) - (g.*sind(u3(i))) + ((u1(i))/(x6(i)));
     der_x5= -((cL(i).*S.*ro(i)).*x4(i).*sind(u2(i)))/(2.*x6(i));
     der_x6= -f(i)/g;
     %-----------------------------------------------------------------------------------------

     %************solution of equation 
     x1(i+1) = x1(i)+ der_x1.*step_size;
     x2(i+1) = x2(i)+ der_x2.*step_size;
     x3(i+1) = x3(i)+ der_x3.*step_size;
     x4(i+1) = x4(i)+ der_x4.*step_size;
     x5(i+1) = x5(i)+ der_x5.*step_size;
     x6(i+1) = x6(i)+ der_x6.*step_size;
     %----------------------------------

     time = i;

     elseif x1(i) > range        
         break
     end
end

last_mass = x6(t_final)
delta_W = (x6(1) - x6(t_final)) * g

%************plotting
subplot(4,2,1);plot3(x1,x2,x3);
grid on
title('3D Position Graph');xlabel('X(m)');ylabel('Y(m)');zlabel('Z (m)');

subplot(4,2,2);plot(t,x4);
title('Speed-Time Graph');xlabel('Time (s)'); ylabel('VTAS (m/s)');

subplot(4,2,3);plot(t,(x4.*sind(u3)));
title('Vertical Speed-Time Graph');xlabel('Time (s)'); ylabel('Vertical Speed (m/s)');

subplot(4,2,4);plot(t,x5);
title('Heading Angle-Time Graph');xlabel('Time(s)'); ylabel('Heading Angle (degree)');

subplot(4,2,5);plot(t,x6);
title('Mass-Time Graph');xlabel('Time (s)'); ylabel('Mass (kg)');

subplot(4,2,6);plot(t,u1);
title('Thrust-Time Graph');xlabel('Time (s)');ylabel('Thrust (N)');

subplot(4,2,7);plot(t,u2);
title('Bank Angle-Time Graph');xlabel('Time (s)'); ylabel('Bank Angle (degree)');


subplot(4,2,8);plot(t,u3);
title('Flight Path Angle-Time Graph');xlabel('Time (s)'); ylabel('Flight Path Angle(degree)');
%--------------------------------------------------------------------------------------------------


