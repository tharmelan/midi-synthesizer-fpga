%% Phasen Modulation

figure(2);
fplot(@(x) sin(2*pi *(x + 1/2*sin(pi*x/2))), [0,5])
hold on;

fplot(@(x) 1/2*sin(pi*x/2), [0,5])
fplot(@(x) sin(pi*x*2), [0,5])
hold off;

%% Frequenz Modulation

figure(2);
fplot(@(x) sin(2*pi*x *(1 + 1/5*sin(pi*x/8))), [0,20])
hold on;

fplot(@(x) 1/5*sin(pi*x/8), [0,20])
hold off;

%%
test()

function test
FigH = figure('position',[360 500 600 400]);
axes('XLim', [0 4], 'units','pixels', ...
     'position',[100 50 400 200], 'NextPlot', 'add');
x     = linspace(0, 4, 500);
y     = sin(2*pi *(x + 1/2*sin(pi*x/2)));
h = plot(x,y);
freq = 32;
phase = 64;
TextFreq = uicontrol('style','text',...
    'position',[170 300 80 15]);


TextPhase = uicontrol('style','text',...
    'position',[170 340 80 15]);

TextCMRatio = uicontrol('style','text',...
    'position',[170 360 180 15]);

Sfreq = uicontrol('style','slider','position',[100 280 400 20],...
    'min', 0, 'max', 127, 'SliderStep', [1/127, 0.1], 'Value', 8);
addlistener(Sfreq, 'Value', 'PostSet',@callbackfnFreq);

Sphase = uicontrol('style','slider','position',[100 320 400 20],...
    'min', 0, 'max', 127, 'SliderStep', [1/127, 0.1], 'Value', 32);
addlistener(Sphase, 'Value', 'PostSet',@callbackfnPhase);

movegui(FigH, 'center')
    function callbackfnFreq(source, eventdata)
    freq          = round(get(eventdata.AffectedObject, 'Value'));
    set(eventdata.AffectedObject, 'Value', freq);
    set(h,'YData',sin(2*pi *(x + 1/64*phase*sin(2*pi*x/(2^5)*freq))));
    TextFreq.String = strcat('Freq: ', num2str(freq));
    TextCMRatio.String = strcat('C:M Ratio  = ', num2str(32/freq));
    end

    function callbackfnPhase(source, eventdata)
    phase          = round(get(eventdata.AffectedObject, 'Value'));
    set(eventdata.AffectedObject, 'Value', phase);
    set(h,'YData',sin(2*pi *(x + 1/64*phase*sin(2*pi*x/(2^5)*freq))));
    TextPhase.String = strcat('Phase: ',num2str(phase));
    end
end

