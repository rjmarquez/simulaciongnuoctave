clear all
close all

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

pkg load control
s = tf("s")

disp("sistema lazo abierto")
G = K*wn*wn/(s^2+2*zita*wn*s+wn^2)
disp("sistema lazo cerrado")
Glc2 = (kP*K*wn^2*s+kI*K*wn^2)/(s^3+2*zita*wn*s*s+(wn*wn+K*kP*wn*wn)*s+kI*K*wn^2)
figure(1)
step(G)
figure(2)
step(Glc2)
