# Simulación
# Control proporcional de un sistema
# de segundo orden con un polo en cero
# Por Richard Marquez
# Ver el archivo LICENSE

clear all
close all

function dx = motor(x,t)
  x1 = x(1);
  x2 = x(2);
  
  # parametros
  K = 0.5;
  b = 2;
  
  # salida
  y = x1;
  
  # referencia
  r = 1;
  
  # control
  kP = 2.5;
  u = kP*(r-y);
  
  # sistema
  dx1 = x2;
  dx2 = -b*x2+K*u;
  
  dx = [dx1; dx2];
endfunction

t = linspace(0,14,200);
x = lsode("motor",[0 0],t);

plot(t,x(:,1))