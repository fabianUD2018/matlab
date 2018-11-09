%%Fabian Camilo Herrera Ramirez 20141020035 
%%luis Enrique Mendez Lopez 20141020032

clear all;close all;


h=0.001;
 x=0.1; 
 y=0.1;
 z=0.1;
 t(1)=0
 n=1
 
%no se si el vectgor e con ; o con ,
v (:,1) = [0.1, 0.1, 0.1];
%sgma =a
a=0.2
b=0.2
c=3;


for iteracion=1:80000
% k1= h*a*(x2-x1);
% m1= h*(r*x1-x2-x1*x3);
% r1= h*(x1*x2-b*x3);
k1=h*(-y-z);
m1= h*(x+a*y);
r1=h*(b+z*(x-c));

k2= h*(-(y+m1/2)-(z+r1/2));
m2= h*((x+k1/2)+a*(y+m1/2));
r2=h*(b+(z+r1/2)*((x+k1/2)-c));

k3= h*(-(y+m2/2)-(z+r2/2));
m3= h*((x+k2/2)+a*(y+m2/2));
r3=h*(b+(z+r2/2)*((x+k2/2)-c));

k4= h*(-(y+m3/2)-(z+r3/2));
m4= h*((x+k3/2)+a*(y+m3/2));
r4=h*(b+(z+r3/2)*((x+k3/2)-c));

% k2= h*a*((x2+m1/2)-(x1+k1/2));
% m2=h*(r*((x1+k1/2))-(x2+m1/2)-((x1+k1/2)*(x3+r1/2)));
% r2=h*((x1+k1/2)*(x2+m1/2)-b*(x3+r1/2)); 
% 
% k3= h*a*((x2+m2/2)-(x1+k2/2));
% m3=h*(r*((x1+k2/2))-(x2+m2/2)-((x1+k2/2)*(x3+r2/2)));
% r3=h*((x1+k2/2)*(x2+m2/2)-b*(x3+r2/2));
% 
% k4= h*a*((x2+m3/2)-(x1+k3/2));
% m4=h*(r*((x1+k3/2))-(x2+m3/2)-((x1+k3/2)*(x3+r3/2)));
% r4=h*((x1+k3/2)*(x2+m3/2)-b*(x3+r3/2));

x=x+((1/6)*(k1+2*k2+2*k3+k4));
y=y+((1/6)*(m1+2*m2+2*m3+m4));
z=z+((1/6)*(r1+2*r2+2*r3+r4));
n=n+1;
t(n)=(n-1)*h;
v(:, n)=[x,  y, z];
end

%plot(t, v(1, :), 's', t, v(2, :), 's')
f1 = figure;
plot3( v(1, :),   v(2, :), v(3,:))
f2 = figure;
subplot(1, 3, 1)

plot (t, v(1,:))
subplot(1, 3, 2)

plot (t, v(2,:))
subplot(1, 3, 3)

plot (t, v(2,:))
% plot ( v(1,:), v(2,:))
% plot(v(2,:), v(3,:))
% plot(v(1,:), v(3,:))

grid