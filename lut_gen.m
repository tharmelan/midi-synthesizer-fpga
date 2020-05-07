func_sin = 'sin(2*pi*x)'; % Define the sine function
xmin = 0; % Set the minimum input of interest
xmax = 1; % Set the maximum input of interest
xdt = ufix(16); % Set the x data type
xscale = 2^-16; % Set the x data scaling
ydt = sfix(16); % Set the y data type
yscale = 2^-14; % Set the y data scaling
rndmeth = 'Floor'; % Set the rounding method
errmax = 2^-10; % Set the maximum allowed error
nptsmax = 2^8; % Specify the maximum number of points
spacing = 'pow2';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_sin,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);

lutSinus = ydata.*4096;
sprintf('%g,',floor(lutSinus))


func_viola = '(339.29*cos(1*2*pi*x--1.366)+6245.16*cos(2*2*pi*x-2.541)+5420.62*cos(3*2*pi*x-1.512)+7117.55*cos(4*2*pi*x-0.506)+7155*cos(5*2*pi*x-2.116)+6795*cos(6*2*pi*x-2.865)+4657.18*cos(7*2*pi*x--0.978)+2281.12*cos(8*2*pi*x-1.648)+6013.29*cos(9*2*pi*x-1.553)+4558.98*cos(10*2*pi*x-0.846)+2667.41*cos(11*2*pi*x-0.734)+1877.8*cos(12*2*pi*x-2.488)+1662.64*cos(13*2*pi*x-0.472)+741.53*cos(14*2*pi*x-1.555)+2128.55*cos(15*2*pi*x-1.17)+1310.88*cos(16*2*pi*x--0.045)+145.48*cos(17*2*pi*x--0.456)+164.67*cos(18*2*pi*x-3.134)+257.88*cos(19*2*pi*x-1.327)+667.32*cos(20*2*pi*x-0.312)+476.89*cos(21*2*pi*x--2.213)+580.86*cos(22*2*pi*x-0.422)+409.94*cos(23*2*pi*x--0.207)+339.64*cos(24*2*pi*x--0.896)+245.94*cos(25*2*pi*x-2.169)+579.16*cos(26*2*pi*x-0.89)+790.47*cos(27*2*pi*x-0.124)+535.37*cos(28*2*pi*x--0.21)+130.35*cos(29*2*pi*x--0.654)+61.82*cos(30*2*pi*x-0.109)+146.09*cos(31*2*pi*x-1.061)+131.01*cos(32*2*pi*x-1.782)+73.99*cos(33*2*pi*x-1.745)+37.3*cos(34*2*pi*x-2.895)+23.14*cos(35*2*pi*x--1.63)+29.25*cos(36*2*pi*x--2.723)+40*cos(37*2*pi*x-0.171)+18.51*cos(38*2*pi*x-0.294)+26.58*cos(39*2*pi*x--2.874)+43.69*cos(40*2*pi*x--2.646)+9.16*cos(41*2*pi*x-0.016)+12.86*cos(42*2*pi*x--1.631)+8.26*cos(43*2*pi*x--0.433)+4.84*cos(44*2*pi*x-2.82)+7.52*cos(45*2*pi*x--0.914)+6.68*cos(46*2*pi*x--2.512)+3.43*cos(47*2*pi*x-2.903)+9.12*cos(48*2*pi*x--1.314)+16.59*cos(49*2*pi*x--0.122)+13.63*cos(50*2*pi*x-0.515)+10.42*cos(51*2*pi*x-2.471)+7.09*cos(52*2*pi*x--1.801)+3.42*cos(53*2*pi*x--0.719)+18.31*cos(54*2*pi*x-0.559)+26.59*cos(55*2*pi*x-1.557)+24.72*cos(56*2*pi*x-2.307)+32.41*cos(57*2*pi*x--2.894)+21.84*cos(58*2*pi*x--2.968)+9.16*cos(59*2*pi*x-3.002)+4.05*cos(60*2*pi*x-2.577)+3.87*cos(61*2*pi*x-2.803)+3.16*cos(62*2*pi*x-0.09)+2.47*cos(63*2*pi*x--1.151)+6.33*cos(64*2*pi*x--1.035)+7.14*cos(65*2*pi*x--0.028)+5.32*cos(66*2*pi*x-0.69)+6.18*cos(67*2*pi*x-2.082)+9.71*cos(68*2*pi*x--3.056)+10.52*cos(69*2*pi*x--2.059)+11.72*cos(70*2*pi*x--1.277)+6.92*cos(71*2*pi*x--0.023)+7.92*cos(72*2*pi*x-0.736))/26630';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_viola,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);
lutViola = ydata*4096;
sprintf('%g,',floor(lutViola))

