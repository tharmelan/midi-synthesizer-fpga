%% Phasen Modulation

figure(1);
fplot(@(x) sin(2*pi *(x + 1/2*sin(pi*x/2))), [0,20])
hold on;

fplot(@(x) 1/5*sin(pi*x/2), [0,20])
hold off;

%% Frequenz Modulation

figure(2);
fplot(@(x) sin(2*pi*x *(1 + 1/5*sin(pi*x/8))), [0,20])
hold on;

fplot(@(x) 1/5*sin(pi*x/8), [0,20])
hold off;