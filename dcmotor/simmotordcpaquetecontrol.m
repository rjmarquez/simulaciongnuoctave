# Simulación
# Control proporcional de un sistema
# de segundo orden con un polo en cero
# Por Richard Marquez
# Ver el archivo LICENSE

clear all
close all

# parametros
global K b kP
# sistema
K = 0.5;
b = 2;

# control
kP = 2.5;


function dx = motor(x,t)
  global K b kP
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

t = linspace(0,14,200);
x = lsode("motor",[0 0],t);

pkg load control
s = tf("s");

# sistema en lazo abierto
G = K/s/(s+b);

# funcion de transferencia en lazo cerrado
Glc = kP*K/(s^2+b*s+kP*K);

# usando algebra de bloques
Glc2 = kP*G/(1+kP*G);

step(Glc) # simulacion de respuesta al escalon
hold on
plot(t,x(:,1))
set(gca,"fontsize",24)
legend("FT Glc","EDO lsode")