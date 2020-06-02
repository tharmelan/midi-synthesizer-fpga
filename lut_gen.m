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
 
%% sinus
func_sin = 'sin(2*pi*x)'; % Define the sine function
[xdata, ydata, errworst] = fixpt_look1_func_approx(func_sin,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);

lutSinus = ydata.*4096;
sprintf('%g,',floor(lutSinus))

%% viola
func_viola = '(339.29*cos(1*2*pi*x--1.366)+6245.16*cos(2*2*pi*x-2.541)+5420.62*cos(3*2*pi*x-1.512)+7117.55*cos(4*2*pi*x-0.506)+7155*cos(5*2*pi*x-2.116)+6795*cos(6*2*pi*x-2.865)+4657.18*cos(7*2*pi*x--0.978)+2281.12*cos(8*2*pi*x-1.648)+6013.29*cos(9*2*pi*x-1.553)+4558.98*cos(10*2*pi*x-0.846)+2667.41*cos(11*2*pi*x-0.734)+1877.8*cos(12*2*pi*x-2.488)+1662.64*cos(13*2*pi*x-0.472)+741.53*cos(14*2*pi*x-1.555)+2128.55*cos(15*2*pi*x-1.17)+1310.88*cos(16*2*pi*x--0.045)+145.48*cos(17*2*pi*x--0.456)+164.67*cos(18*2*pi*x-3.134)+257.88*cos(19*2*pi*x-1.327)+667.32*cos(20*2*pi*x-0.312)+476.89*cos(21*2*pi*x--2.213)+580.86*cos(22*2*pi*x-0.422)+409.94*cos(23*2*pi*x--0.207)+339.64*cos(24*2*pi*x--0.896)+245.94*cos(25*2*pi*x-2.169)+579.16*cos(26*2*pi*x-0.89)+790.47*cos(27*2*pi*x-0.124)+535.37*cos(28*2*pi*x--0.21)+130.35*cos(29*2*pi*x--0.654)+61.82*cos(30*2*pi*x-0.109)+146.09*cos(31*2*pi*x-1.061)+131.01*cos(32*2*pi*x-1.782)+73.99*cos(33*2*pi*x-1.745)+37.3*cos(34*2*pi*x-2.895)+23.14*cos(35*2*pi*x--1.63)+29.25*cos(36*2*pi*x--2.723)+40*cos(37*2*pi*x-0.171)+18.51*cos(38*2*pi*x-0.294)+26.58*cos(39*2*pi*x--2.874)+43.69*cos(40*2*pi*x--2.646)+9.16*cos(41*2*pi*x-0.016)+12.86*cos(42*2*pi*x--1.631)+8.26*cos(43*2*pi*x--0.433)+4.84*cos(44*2*pi*x-2.82)+7.52*cos(45*2*pi*x--0.914)+6.68*cos(46*2*pi*x--2.512)+3.43*cos(47*2*pi*x-2.903)+9.12*cos(48*2*pi*x--1.314)+16.59*cos(49*2*pi*x--0.122)+13.63*cos(50*2*pi*x-0.515)+10.42*cos(51*2*pi*x-2.471)+7.09*cos(52*2*pi*x--1.801)+3.42*cos(53*2*pi*x--0.719)+18.31*cos(54*2*pi*x-0.559)+26.59*cos(55*2*pi*x-1.557)+24.72*cos(56*2*pi*x-2.307)+32.41*cos(57*2*pi*x--2.894)+21.84*cos(58*2*pi*x--2.968)+9.16*cos(59*2*pi*x-3.002)+4.05*cos(60*2*pi*x-2.577)+3.87*cos(61*2*pi*x-2.803)+3.16*cos(62*2*pi*x-0.09)+2.47*cos(63*2*pi*x--1.151)+6.33*cos(64*2*pi*x--1.035)+7.14*cos(65*2*pi*x--0.028)+5.32*cos(66*2*pi*x-0.69)+6.18*cos(67*2*pi*x-2.082)+9.71*cos(68*2*pi*x--3.056)+10.52*cos(69*2*pi*x--2.059)+11.72*cos(70*2*pi*x--1.277)+6.92*cos(71*2*pi*x--0.023)+7.92*cos(72*2*pi*x-0.736))/26630';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_viola,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);
lutViola = ydata*4096;
sprintf('%g,',floor(lutViola))

%% Bassoon
%maxvalue = 12495
func_bassoon = '(1496.02*cos(2*pi*x*1-0.62)+1760.13*cos(2*pi*x*2-(-2.921))+1463.1*cos(2*pi*x*3-0.672)+1494.06*cos(2*pi*x*4-2.691)+554.89*cos(2*pi*x*5-(-1.052))+1828.66*cos(2*pi*x*6-(-0.283))+3267.2*cos(2*pi*x*7-2.344)+2507.71*cos(2*pi*x*8-(-0.514))+2822.65*cos(2*pi*x*9-(-1.621))+3791.0*cos(2*pi*x*10-1.599)+1014.94*cos(2*pi*x*11-(-1.74))+986.36*cos(2*pi*x*12-1.503)+234.62*cos(2*pi*x*13-(-2.063))+211.31*cos(2*pi*x*14-1.465)+276.29*cos(2*pi*x*15-(-2.86))+256.48*cos(2*pi*x*16-(-0.911))+102.98*cos(2*pi*x*17-2.727)+65.56*cos(2*pi*x*18-2.104)+405.17*cos(2*pi*x*19-(-0.934))+185.31*cos(2*pi*x*20-2.148)+320.75*cos(2*pi*x*21-(-0.554))+59.29*cos(2*pi*x*22-(-2.715))+119.16*cos(2*pi*x*23-(-0.949))+233.4*cos(2*pi*x*24-1.742)+279.55*cos(2*pi*x*25-(-1.653))+231.5*cos(2*pi*x*26-0.885)+191.63*cos(2*pi*x*27-(-2.58))+72.66*cos(2*pi*x*28-(-1.028))+136.57*cos(2*pi*x*29-(-2.278))+48.22*cos(2*pi*x*30-(-1.373))+85.26*cos(2*pi*x*31-(-2.739))+43.16*cos(2*pi*x*32-(-2.724))+40.03*cos(2*pi*x*33-(-2.699))+70.39*cos(2*pi*x*34-(-2.647)))/12495';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_bassoon,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);
lutBassoon = ydata*4096;
bassoon = sprintf('%g,',floor(lutBassoon))

%% Clarinet
%maxvalue = 5228;
fplot(@(x) 2129.0*cos(2*pi*x*1-(-2.305))+141.25*cos(2*pi*x*2-2.652)+1501.38*cos(2*pi*x*3-(-1.61))+497.77*cos(2*pi*x*4-(-2.366))+1578.43*cos(2*pi*x*5-(-0.999))+824.85*cos(2*pi*x*6-(-2.851))+572.4*cos(2*pi*x*7-(-1.776))+368.78*cos(2*pi*x*8-0.82)+473.54*cos(2*pi*x*9-(-0.646))+440.16*cos(2*pi*x*10-(-0.84))+102.03*cos(2*pi*x*11-(-0.6))+198.78*cos(2*pi*x*12-(-1.504))+130.51*cos(2*pi*x*13-(-0.554))+45.72*cos(2*pi*x*14-(-1.733))+57.46*cos(2*pi*x*15-4.8e-2)+52.97*cos(2*pi*x*16-(-0.341))+52.77*cos(2*pi*x*18-0.245)+22.49*cos(2*pi*x*19-(-1.054))+30.28*cos(2*pi*x*21-(-0.304))+26.43*cos(2*pi*x*24-(-1.674))+30.37*cos(2*pi*x*26-(-0.882)),[0,1])

func_clarinet = '(2129.0*cos(2*pi*x*1-(-2.305))+141.25*cos(2*pi*x*2-2.652)+1501.38*cos(2*pi*x*3-(-1.61))+497.77*cos(2*pi*x*4-(-2.366))+1578.43*cos(2*pi*x*5-(-0.999))+824.85*cos(2*pi*x*6-(-2.851))+572.4*cos(2*pi*x*7-(-1.776))+368.78*cos(2*pi*x*8-0.82)+473.54*cos(2*pi*x*9-(-0.646))+440.16*cos(2*pi*x*10-(-0.84))+102.03*cos(2*pi*x*11-(-0.6))+198.78*cos(2*pi*x*12-(-1.504))+130.51*cos(2*pi*x*13-(-0.554))+45.72*cos(2*pi*x*14-(-1.733))+57.46*cos(2*pi*x*15-4.8e-2)+52.97*cos(2*pi*x*16-(-0.341))+52.77*cos(2*pi*x*18-0.245)+22.49*cos(2*pi*x*19-(-1.054))+30.28*cos(2*pi*x*21-(-0.304))+26.43*cos(2*pi*x*24-(-1.674))+30.37*cos(2*pi*x*26-(-0.882)))/5228';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_clarinet,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);
lutclarinet = ydata*4096;
clarinet = sprintf('%g,',floor(lutclarinet))

%% English Horn
%maxvalue = 13382;
fplot(@(x) 733.4*cos(2*pi*x*1-(-1.421))+1005.37*cos(2*pi*x*2-(-2.085))+2608.86*cos(2*pi*x*3-(-1.166))+3380.3*cos(2*pi*x*4-(-1.656))+4449.0*cos(2*pi*x*5-(-1.938))+2461.16*cos(2*pi*x*6-(-1.956))+553.79*cos(2*pi*x*7-(-1.697))+305.71*cos(2*pi*x*8-(-0.832))+68.55*cos(2*pi*x*9-(-1.077))+147.97*cos(2*pi*x*10-2.26)+75.32*cos(2*pi*x*11-(-2.476))+88.28*cos(2*pi*x*12-(-1.13))+143.39*cos(2*pi*x*13-(-0.87))+46.76*cos(2*pi*x*14-(-0.987))+24.71*cos(2*pi*x*16-2.774)+85.34*cos(2*pi*x*18-(-1.957))+69.0*cos(2*pi*x*19-(-1.983))+48.72*cos(2*pi*x*21-0.258)+89.41*cos(2*pi*x*22-0.274)+101.49*cos(2*pi*x*23-(-0.583))+24.07*cos(2*pi*x*31-1.301),[0,1])

func_english_horn = '(733.4*cos(2*pi*x*1-(-1.421))+1005.37*cos(2*pi*x*2-(-2.085))+2608.86*cos(2*pi*x*3-(-1.166))+3380.3*cos(2*pi*x*4-(-1.656))+4449.0*cos(2*pi*x*5-(-1.938))+2461.16*cos(2*pi*x*6-(-1.956))+553.79*cos(2*pi*x*7-(-1.697))+305.71*cos(2*pi*x*8-(-0.832))+68.55*cos(2*pi*x*9-(-1.077))+147.97*cos(2*pi*x*10-2.26)+75.32*cos(2*pi*x*11-(-2.476))+88.28*cos(2*pi*x*12-(-1.13))+143.39*cos(2*pi*x*13-(-0.87))+46.76*cos(2*pi*x*14-(-0.987))+24.71*cos(2*pi*x*16-2.774)+85.34*cos(2*pi*x*18-(-1.957))+69.0*cos(2*pi*x*19-(-1.983))+48.72*cos(2*pi*x*21-0.258)+89.41*cos(2*pi*x*22-0.274)+101.49*cos(2*pi*x*23-(-0.583))+24.07*cos(2*pi*x*31-1.301))/13382';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_english_horn,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);
lut_english_horn = ydata*4096;
english_horn = sprintf('%g,',floor(lut_english_horn))

%% Flute
%maxvalue = 7232;
fplot(@(x) 983.6*cos(2*pi*x*1-2.613)+2957.0*cos(2*pi*x*2-(-0.878))+1419.21*cos(2*pi*x*3-2.019)+790.14*cos(2*pi*x*4-(-2.39))+1128.71*cos(2*pi*x*5-0.891)+427.98*cos(2*pi*x*6-2.883)+290.77*cos(2*pi*x*7-(-2.134))+486.62*cos(2*pi*x*8-0.139)+221.42*cos(2*pi*x*9-3.074)+75.69*cos(2*pi*x*10-3.047)+102.28*cos(2*pi*x*11-1.022)+34.48*cos(2*pi*x*12-(-1.293))+21.73*cos(2*pi*x*13-(-2.222)),[0,1])

func_flute = '(983.6*cos(2*pi*x*1-2.613)+2957.0*cos(2*pi*x*2-(-0.878))+1419.21*cos(2*pi*x*3-2.019)+790.14*cos(2*pi*x*4-(-2.39))+1128.71*cos(2*pi*x*5-0.891)+427.98*cos(2*pi*x*6-2.883)+290.77*cos(2*pi*x*7-(-2.134))+486.62*cos(2*pi*x*8-0.139)+221.42*cos(2*pi*x*9-3.074)+75.69*cos(2*pi*x*10-3.047)+102.28*cos(2*pi*x*11-1.022)+34.48*cos(2*pi*x*12-(-1.293))+21.73*cos(2*pi*x*13-(-2.222)))/7232';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_flute,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);
lut_flute = ydata*4096;
flute = sprintf('%g,',floor(lut_flute))

%% Violin
%maxvalue = 9793;
fplot(@(x) 173.02*cos(2*pi*x*1-(-8.3e-2))+3813.0*cos(2*pi*x*2-0.72)+454.04*cos(2*pi*x*3-1.575)+1899.6*cos(2*pi*x*4-2.304)+3417.4*cos(2*pi*x*5-(-0.804))+986.9*cos(2*pi*x*6-2.995)+814.25*cos(2*pi*x*7-(-2.61))+1862.38*cos(2*pi*x*8-(-2.291))+898.19*cos(2*pi*x*9-(-2.437))+521.5*cos(2*pi*x*10-1.441)+567.77*cos(2*pi*x*11-(-1.743))+397.94*cos(2*pi*x*12-1.368)+584.15*cos(2*pi*x*13-(-2.803))+558.45*cos(2*pi*x*14-2.268)+324.64*cos(2*pi*x*15-2.383)+393.41*cos(2*pi*x*16-(-1.043))+53.85*cos(2*pi*x*17-(-0.854))+182.05*cos(2*pi*x*18-(-1.107))+116.59*cos(2*pi*x*19-2.952)+99.54*cos(2*pi*x*20-0.778)+41.28*cos(2*pi*x*21-(-3.108))+149.15*cos(2*pi*x*22-2.726)+147.38*cos(2*pi*x*23-0.183)+112.62*cos(2*pi*x*24-(-2.349))+76.83*cos(2*pi*x*25-1.523)+34.51*cos(2*pi*x*26-0.967)+54.77*cos(2*pi*x*27-0.144)+23.94*cos(2*pi*x*28-0.437)+61.97*cos(2*pi*x*29-(-0.777))+48.0*cos(2*pi*x*30-(-1.767))+34.61*cos(2*pi*x*31-(-3.072))+23.41*cos(2*pi*x*33-2.77),[0,1])

func_violin = '(173.02*cos(2*pi*x*1-(-8.3e-2))+3813.0*cos(2*pi*x*2-0.72)+454.04*cos(2*pi*x*3-1.575)+1899.6*cos(2*pi*x*4-2.304)+3417.4*cos(2*pi*x*5-(-0.804))+986.9*cos(2*pi*x*6-2.995)+814.25*cos(2*pi*x*7-(-2.61))+1862.38*cos(2*pi*x*8-(-2.291))+898.19*cos(2*pi*x*9-(-2.437))+521.5*cos(2*pi*x*10-1.441)+567.77*cos(2*pi*x*11-(-1.743))+397.94*cos(2*pi*x*12-1.368)+584.15*cos(2*pi*x*13-(-2.803))+558.45*cos(2*pi*x*14-2.268)+324.64*cos(2*pi*x*15-2.383)+393.41*cos(2*pi*x*16-(-1.043))+53.85*cos(2*pi*x*17-(-0.854))+182.05*cos(2*pi*x*18-(-1.107))+116.59*cos(2*pi*x*19-2.952)+99.54*cos(2*pi*x*20-0.778)+41.28*cos(2*pi*x*21-(-3.108))+149.15*cos(2*pi*x*22-2.726)+147.38*cos(2*pi*x*23-0.183)+112.62*cos(2*pi*x*24-(-2.349))+76.83*cos(2*pi*x*25-1.523)+34.51*cos(2*pi*x*26-0.967)+54.77*cos(2*pi*x*27-0.144)+23.94*cos(2*pi*x*28-0.437)+61.97*cos(2*pi*x*29-(-0.777))+48.0*cos(2*pi*x*30-(-1.767))+34.61*cos(2*pi*x*31-(-3.072))+23.41*cos(2*pi*x*33-2.77))/9793';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_violin,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);
lut_violin = ydata*4096;
violin = sprintf('%g,',floor(lut_violin))

%% Tuba
%maxvalue = 8101;
fplot(@(x) 843.88*cos(2*pi*x*1-7.8e-2)+2099.0*cos(2*pi*x*2-(-0.354))+878.93*cos(2*pi*x*3-(-0.561))+1884.7*cos(2*pi*x*4-(-1.876))+1943.73*cos(2*pi*x*5-(-2.319))+738.9*cos(2*pi*x*6-(-3.108))+750.4*cos(2*pi*x*7-(-2.768))+192.84*cos(2*pi*x*8-1.549)+84.29*cos(2*pi*x*9-(-0.208))+54.7*cos(2*pi*x*10-1.535)+201.61*cos(2*pi*x*11-(-1.404))+186.67*cos(2*pi*x*12-(-2.883))+80.84*cos(2*pi*x*13-2.992)+87.26*cos(2*pi*x*14-1.899)+43.02*cos(2*pi*x*15-0.34)+24.34*cos(2*pi*x*18-(-0.741)),[0,1])

func_tuba = '(843.88*cos(2*pi*x*1-7.8e-2)+2099.0*cos(2*pi*x*2-(-0.354))+878.93*cos(2*pi*x*3-(-0.561))+1884.7*cos(2*pi*x*4-(-1.876))+1943.73*cos(2*pi*x*5-(-2.319))+738.9*cos(2*pi*x*6-(-3.108))+750.4*cos(2*pi*x*7-(-2.768))+192.84*cos(2*pi*x*8-1.549)+84.29*cos(2*pi*x*9-(-0.208))+54.7*cos(2*pi*x*10-1.535)+201.61*cos(2*pi*x*11-(-1.404))+186.67*cos(2*pi*x*12-(-2.883))+80.84*cos(2*pi*x*13-2.992)+87.26*cos(2*pi*x*14-1.899)+43.02*cos(2*pi*x*15-0.34)+24.34*cos(2*pi*x*18-(-0.741)))/8101';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_tuba,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);
lut_tuba = ydata*4096;
tuba = sprintf('%g,',floor(lut_tuba))

%% Piccolo
%maxvalue = 1346;
fplot(@(x) 972.0*cos(2*pi*x*1-(-1.937))+110.39*cos(2*pi*x*2-1.5e-2)+353.86*cos(2*pi*x*3-(-1.488))+193.81*cos(2*pi*x*4-(-0.313))+33.06*cos(2*pi*x*5-2.853)+87.82*cos(2*pi*x*6-(-0.46))+25.57*cos(2*pi*x*7-1.985)+17.09*cos(2*pi*x*8-(-0.719))+15.11*cos(2*pi*x*9-2.218)+7.93*cos(2*pi*x*11-2.308)+7.27*cos(2*pi*x*12-(-2.572))+6.58*cos(2*pi*x*13-(-3.9e-2))+6.24*cos(2*pi*x*14-2.642)+3.51*cos(2*pi*x*15-0.478),[0,1])

func_piccolo = '(972.0*cos(2*pi*x*1-(-1.937))+110.39*cos(2*pi*x*2-1.5e-2)+353.86*cos(2*pi*x*3-(-1.488))+193.81*cos(2*pi*x*4-(-0.313))+33.06*cos(2*pi*x*5-2.853)+87.82*cos(2*pi*x*6-(-0.46))+25.57*cos(2*pi*x*7-1.985)+17.09*cos(2*pi*x*8-(-0.719))+15.11*cos(2*pi*x*9-2.218)+7.93*cos(2*pi*x*11-2.308)+7.27*cos(2*pi*x*12-(-2.572))+6.58*cos(2*pi*x*13-(-3.9e-2))+6.24*cos(2*pi*x*14-2.642)+3.51*cos(2*pi*x*15-0.478))/1346';

[xdata, ydata, errworst] = fixpt_look1_func_approx(func_piccolo,xmin,xmax,xdt,xscale,ydt,yscale,rndmeth,[],nptsmax,spacing);
lut_piccolo = ydata*4096;
piccolo = sprintf('%g,',floor(lut_piccolo))


