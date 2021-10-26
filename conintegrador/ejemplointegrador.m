%clear all
%close all

global wn zita K kP kI
wn = 1;
zita = 0.7;
K = 2;
kP = 1;
kI = 1;

disp("polos en lazo abierto")
roots([1 2*zita*wn wn*wn])

disp("polos en lazo cerrado")
roots([1 2*zita*wn (wn*wn+K*kP*wn ^2) kI*K*wn^2])


function dx = f(x,t)
  global wn zita K kP kI
  x1 = x(1);
  x2 = x(2);
  z1 = x(3);
  y = x1;
  
  r = t>0;

  er = r-y;
  
  u = kP*er+kI*z1;
  dz1 = er;
 
  dx1 = x2;
  dx2 = -2*zita*wn*x2-wn*wn*x1+K*wn*wn*u; 
  dx = [dx1;dx2;dz1];
endfunction

x0 = [0 0 0];
t = linspace(0,20,500);
x = lsode("f",x0,t);
subplot(211)
plot(t,x(:,1))
grid
title("y")
set(gca,"fontsize",24)

subplot(212)
plot(t,x(:,2))
grid
title("derivada de x1 = y")
set(gca,"fontsize",24)

