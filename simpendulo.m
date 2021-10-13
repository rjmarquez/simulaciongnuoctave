# Simulación del control de un péndulo simple
# Por Richard Marquez
# Ver el archivo LICENCE

clear all
close all

global g L kP kD

# parametros del sistema
g = 9.8;
L = 0.2;
  
# parametros del controlador
kD = 0; # 11.9413 # 1
kP = 1;

global barx1 barx2 baru
# punto de equilibrio
barx1 = 0; # pi/4
barx2 = 0;
baru = g/L*cos(barx1);

roots([1 kD g/L*cos(barx1)+kP])


function dx = pendulo(x,t)
  global g L kP kD barx1 barx2 baru
  x1 = x(1);
  x2 = x(2);
    
  
  # variables lineales
  x1d = x1-barx1;
  x2d = x2-barx2;
  
  ud = -kP*x1d-kD*x2d;
  u = ud+baru;
 
  dx1 = x2;
  dx2 = -g/L*sin(x1)+u; 
  dx = [dx1;dx2];
endfunction

function dx = pendulolineal(x,t)
  global g L kD kP barx1 barx2 baru
  x1d = x(1);
  x2d = x(2);
  
  ud = -kP*x1d-kD*x2d;
 
  dx1d = x2d;
  dx2d = -g/L*cos(barx1)*x1d+ud; 
  dx = [dx1d;dx2d];
endfunction

x0g = [60 30];

x0 = x0g/180*pi;
x0d = x0-[barx1 barx2];

t = linspace(0,10,200);
xd = lsode("pendulolineal",x0d,t);
subplot(211)
plot(t,xd(:,1)*180/pi)
grid
title("posicion angular (lineal)")
set(gca,"fontsize",24)

subplot(212)
plot(t,xd(:,2))
grid
title("velocidad angular (lineal)")
set(gca,"fontsize",24)

figure
x = lsode("pendulo",x0,t);
subplot(211)
plot(t,x(:,1)*180/pi)
grid
title("posicion angular")
set(gca,"fontsize",24)

subplot(212)
plot(t,x(:,2))
grid
title("velocidad angular")
set(gca,"fontsize",24)
