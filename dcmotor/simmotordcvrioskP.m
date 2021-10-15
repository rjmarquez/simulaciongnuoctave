# Simulación
# Control proporcional de un sistema
# de segundo orden con un polo en cero
# con cambio del parametro kP
# Por Richard Marquez
# Ver el archivo LICENSE
clear all
close all

# parametros
global kP K b
K = 0.5;
b = 2;

function dx = motor(x,t)
  global kP K b
  x1 = x(1);
  x2 = x(2);
    
  # salida
  y = x1;
  
  # referencia
  r = 1;
  
  # control
  u = kP*(r-y);
  
  # sistema
  dx1 = x2;
  dx2 = -b*x2+K*u;
  
  dx = [dx1; dx2];
endfunction

kPv = [0.1 0.5 1:0.2:2 4 10 100]*b^2/4/K;
figure
for k = 1:length(kPv),
  kP = kPv(k);
  t = linspace(0,14,400);
  x = lsode("motor",[0 0],t);

  plot(t,x(:,1))
  set(gca,"fontsize",24)
  text(t(50),x(50,1),num2str(kPv(k)))
  hold on
endfor
grid