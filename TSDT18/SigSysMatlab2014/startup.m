%STARTUP Initiering av Kretslab.
%    
%    Beskrivning:
%    Startupfilen körs automatiskt när man startar Matlab och om Kretslab 
%    ligger först i Matlabs sökväg. Den definierar ett antal globala variabler 
%    som används av Kretslab. Om man skulle råka ta bort eller definiera om 
%    dessa variabler (t.ex. om man råkar använda pack) kan initieringen göras om 
%    utan att starta om Matlab genom att skriva startup.
%
%    Kretslabs globala variabler är  pm1, pm2, pm3, pm4, KlabL och FSMAX:
%       * Variablerna pm1, pm2, pm3 och pm4 kan användas av DIG i
%         kretslabfunktioner där en önskad variabel förekommer i ett
%         textuttryck. 
%         Exempel: pm1=0.2; pm2=14; x=in('pm1*sin(2*pi*pm2*t)','t');
%       * KlabL och FSMAX skall/får normalt INTE ändras av användaren.
%         KlabL anger längden på Kretslabs signalvektorer (65536) och
%         FSMAX är den högsta sampelfrekvens (6400 Hz) som används av 
%         de flesta Kretslabfunktioner, exempelvis funktionen in.
%    
%    See also:
%    CLEANUP
%    

global pm1 pm2 pm3 pm4 KlabL FSMAX
pm1=0;
pm2=0;
pm3=0;
pm4=0;
KlabL=65536;    % Signal and spectrum vector length (65536)
FSMAX=6400;     % Maximum sample frequency for representing time continuous signals using the in function (earlier: 400  now: 6400)

disp(' ')
disp('Kretslab v3.5 är initierad!')
disp('OBS - Funktionshjälp finns för varje Kretslabfunktion!')
disp(' * Skriv ''helpwin funktionsnamn'' eller ''help funktionsnamn'' för att')
disp('   erhålla hjälptexten till funktionen ''funktionsnamn''.')
disp(' * Skriv även ''helpwin vartype'' (eller ''help vartype'') för att')
disp('   se vilka variabeltyper som används i Kretslab.')
disp(' ')
disp('Den mest lättlästa versionen av hjälptexterna till Kretslabs olika')
disp('funktioner erhålls med hjälp av Matlabs hjälpnavigerare!')
disp('Skriv ''kretslab''!!')
disp('       #########')
disp(' ')


