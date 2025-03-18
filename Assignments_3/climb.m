clc;
clear; 

h1 = 5000; %meter
h2 = 8000; %meter
path_angle=7;

g = 9.80665;
S= 162.12;

step_size=1;
t_final= 150;
t= 0:step_size:t_final;

ro=zeros(size(t));
x1 = zeros(size(t));
x2 = zeros(size(t));
x3 = zeros(size(t));
x4 = zeros(size(t));
x5 = zeros(size(t));
x6 = zeros(size(t));

%%%%initial values
x1(1)=0; 
x2(1)=0;
x3(1)=h1; 
x4(1)=0.514444*Vnom_cl(x3(1)*3.2808399); %knot to m/s
x5(1)=0;
x6(1)=58960;


for i= 1:t_final
    
    path_angle(i)=7;   
    u2(i)=0;
    ro(i)= (101325.*(1-x3(i)/44330.8).^5.256)/(287.05287.*(288.15-0.0065.*x3(i)));
    
    cL(i) = (2.*(x6(i).*g))./(ro(i).*(x4(i).^2).*S.*(cosd(u2(i))));
    cD(i) = 0.04339 +  0.040074*(cL(i).^2);
    f(i) = fconclimb(x3(i)*3.2808399)/60;  %N/s
    D(i) = (0.5).*ro(i).*(x4(i)^2).*S.*cD(i);
    
    if x3(i) <= h2
    u1(i)= D(i)+(x6(i).*g.*sind(path_angle(i)));
    der_x1= x4(i).*cosd(x5(i)).*cosd(7);
    der_x2= x4(i).*sind(x5(i)).*cosd(7);
    der_x3= x4(i).*sind(path_angle(i));
    der_x4= -((0.1077*S.*ro(i)*((x4(i)).^2))/(2*x6(i))) - (g.*sind(path_angle(i))) + ((u1(i))/(x6(i)));
    der_x5= -((cL(i).*S.*ro(i)).*x4(i).*sind(u2(i)))/(2.*x6(i));
    der_x6= -f(i);
    
    x1(i+1) = x1(i)+ der_x1.*step_size;
    x2(i+1) = x2(i)+ der_x2.*step_size;
    x3(i+1) = x3(i)+ der_x3.*step_size;
    x4(i+1) = x4(i)+ der_x4.*step_size;
    x5(i+1) = x5(i)+ der_x5.*step_size;
    x6(i+1) = x6(i)+ der_x6.*step_size;
    
    elseif x3(i) > h2
        break
        
    end
    
end

subplot(4,2,1);
plot3(x1(:),x2(:),x3(:))
grid on
title('3D Position Graph')
xlabel('X(m)');ylabel('Y(m)');zlabel('Z (m)')

subplot(4,2,2);
plot(t,x4(:))
title('Speed-Time Graph')
xlabel('Time (s)'); ylabel('VTAS (m/s)')

subplot(4,2,3);
plot(t,(x4(:).*sind(path_angle)))
title('Vertical Speed-Time Graph')
xlabel('Time (s)'); ylabel('Vertical Speed (m/s)')

subplot(4,2,4);
plot(t,x5(:))
title('Heading Angle-Time Graph')
xlabel('Time(s)'); ylabel('Heading Angle (degree)')

subplot(4,2,5);
plot(t,x6(:))
title('Mass-Time Graph')
xlabel('Time (s)'); ylabel('Mass (kg)')

subplot(4,2,6);
plot(t(1:t_final),u1(:))
title('Thrust-Time Graph')
xlabel('Time (s)');ylabel('Thrust (N)')

subplot(4,2,7);
plot(t(1:t_final),u2)
title('Bank Angle-Time Graph')
xlabel('Time (s)'); ylabel('Bank Angle (degree)');


subplot(4,2,8);
plot(t(1:t_final),path_angle);
title('Flight Path Angle-Time Graph')
xlabel('Time (s)'); ylabel('Flight Path Angle(degree)')
