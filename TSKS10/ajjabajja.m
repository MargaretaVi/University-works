% Laboration 1 TSKS10 
% Joel Martinsson (joema115@student.liu.se)
%
% 2013-02-06

%% Start
% Laddar in den givna ljudfilen till en vektor 'yin' och tar ?ven ut sampel-
% frekvensen 'fs' direkt ur filen.
[yin fs] = wavread('marvi154.wav');

% Enligt uppgiften sÂ ?r ljudet uppdelat i 3 delar.
% Delar sÂdeles upp filen i dessa delar f?r att l?ttare arbeta med.

y_voice = yin(1:2600000);
y_music = yin(2600000:5200000);
y_noice = yin(5200000:7800000);

%% B?rfrekvensen fc
% vi tar en del av ljudet. i detta fallet musiken och transformerar det
% till frekvensdom?nen.
% plottar mot frekvensen och ser hur de ?r koncentrerade.
Y = fft(y_music);
w = [0:fs/length(Y):fs];
w = w(2:length(w));
plot(w,abs(Y));
title('Frekvensgraf ?ver signalen.');
xlabel('Frekvens (Hz)');
ylabel('Amplitud f?r transformen');

% Grafen ger 3 m?jliga b?rfrekvenser: 60 kHz, 100 kHz, 160 kHz. De ?vriga ?r
% speglingar kring 200 kHz (400/2) av de tidigare och uppfyller ej 
% kriteriet att b?rvÂgen ska vara minst 2 ggr ?n sampelfrekvensen (400 kHz).

fc = 100000;


%% Delta Tau!
% B?rjar med att finna delta tau. DÂ tau1 ?r mycket mindre ?n tau2 sÂ
% f?rsummas denna i denna utr?kning sÂ det som tas ut ?r den totala
% skillnaden |tau1-tau2|. 

% Korrelerar bruset med sig sj?lv.
corr_noice = xcorr(y_noice);

n = (1:size(corr_noice));
tidaxel = n./fs;
plot(tidaxel,corr_noice);
title('Korrelations graf f?r brus.');
xlabel('Tid');
ylabel('Korrelation');


% St?rsta toppen ligger pÂ 2.6e6, andra pÂ 2.768e6
% distans mellan topparna 0.168e6.
% differensen blir dÂ i tid
differens_diskret = 0.168*10^6;
differens_tid = 0.168*10^6/fs;

%% Filtrering av eko
% f?r att Âterst?lla det filter som ljudet har gÂtt igenom sÂ k?rs en
% inversfiltrering pÂ varje element. 

x = yin;
% B?rjar att filtrera pÂ differens_diskret ty att den ?r f?rskjuten och
% sÂ att man kommer Ât f?rsta v?rdet. 
% gÂr igenom alla v?rden och drar ifrÂn det eko som lades till tidigare.

 for i=differens_diskret+1:length(x)
 x(i) = x(i)-0.9*x(i-differens_diskret);
 end 
 
 
%%  Demodulering av signal
 
% F?r att ta ut sista differensen mellan de 2 signalerna sÂ testades en
% f?rskjutning fram f?r b?sta resultat
 d = 1;
 % Demodulering av delarna Xi och Xq
 t = (0:1/fs:((size(x)-1)/fs))';
    xi = 2*x.*cos(2*pi*fc*t-d);
    xq = 2*x.*sin(2*pi*fc*t-d);
 % LÂgpassfiltrering pÂ en cutoff-frekvens fc.
 tau_1 = d/(2*pi*fc)
 
    [b,a]=butter(5,fc*2/fs);

        xi = filtfilt(b,a,xi);
        xq = filtfilt(b,a,xq);
        

%% Nedsampling och uppspelning
% Omsamplar ner med en faktor 10.
% S?nker samplefrekvensen f?r att matlab inte klarar sÂ h?ga frekvenser
% som samplingsfrekvensen. 

y_resample = resample(yin,1,10);
xi_resample = resample(xi,1,10);
xq_resample = resample(xq,1,10);

% Spelar upp delarna efter varandra

%soundsc(y_resample,fs/10);
soundsc(xi_resample,fs/10);
soundsc(xq_resample,fs/10);

