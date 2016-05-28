function [TPHAT] = SFlabFindPulseTimes(recBuffer,recChanList,playChanList,...
    sampRate,pulseFreq,pulseWidth,npt,time,plotOn,soundSeq,hada)
%
% Function that finds the pulse times in a recording buffer.
%
% function [TPHAT] = SFlabFindPulseTimes(recBuffer,recChanList,playChanList,...
%     sampRate,pulseFreq,pulseWidth,npt,time,plotOn)
%
% INPUTS:
% recBuffer    -  NxM-matrix with sound data, where M=length(mics) and
%                 N = (sample freq)*(time). Each column contains data from
%                 one of the microphones.
% recChanList  -  Vector with the recording channels that were used.
% playChanList -  Vector with the output channels that were used.
% sampRate     -  Sampling frequency.
% pulseFreq    -  Vector with pulse frequencies.
% pulseWidth   -  Vector with width of the pulses.
% npt          -  Vector with number of pulses per second for each output
%                 channel.
% time         -  Length in seconds of the recording.
% plotOn       -  Plot option, set 1 to plot, 0 otherwise.
% soundSeq     -  Matrix containing sound that was played. [] if external
%                 speaker was used.
%
% OUTPUTS:
% TPHAT        -  Matrix with pulse times, element (:,m,n) contains the
%                 pulse times for microphone m from speaker n.
%
%

% Martin Skoglund and Karl Granström
% 2009-03-24

% Number of microphones used
M = length(recChanList);

% Number of sound sources used
N = length(playChanList);
% Assuming there is one external sound source if no internal
if N == 0, N=1; playChanList = 1; end

% Maximum number of pulses
npmax = floor(max(npt*time));

% Allocate memory
TPHAT = zeros(npmax,M,N);

display('...finding pulse times')
for n = 1:N
    display(['......speaker ' num2str(playChanList(n))])
    % Total number of pulses
    n_pulse = ceil(npt(n)*time);    
    
    % Length of pulse in seconds
    tnp = time/n_pulse;
      
    if isempty(soundSeq)
        % Bandpass filter
        [b,a]=butter(2,[pulseFreq(n)-200 pulseFreq(n)+200]/(sampRate/2));    
    else

    end


    load pulse_waveform
    for m=1:M
        display(['.........microphone ' num2str(recChanList(m))])
        % filter the signal through bandpass filter
        y = recBuffer(:,m); 

        yf=filtfilt(b,a,y);

        % convolute with signal
        yc=conv(yf,h2);
        yc=yc(round(length(h2)/2):(end-round(length(h2)/2)-1));
        yc=abs(yc); %If the polarity of the microphones are unknown (performance can be improved if this line is removed!)
        
        % Find the pulse indices
        minDist = sampRate*tnp*0.95;
        pidx = SFlabFindPulseInd(yc,n_pulse,minDist);
         while((min(diff(sort(pidx)))<(1/npt*sampRate*0.9)))
             disp('Drop Peak')
             n_pulse=n_pulse-1;
             pidx = SFlabFindPulseInd(yc,n_pulse,minDist);
         end

        % Calculate the times
        tphat = (pidx(1:n_pulse)-0.5*(length(h)+1))/sampRate;%-t(end-1)/2;
        % Sort pulse times
        TPHAT(1:n_pulse,m,n) = sort(tphat);

        % Create plots
        if plotOn
            figure(100),clf
            subplot(3,1,1)
            plot((1:length(recBuffer(:,m)))/sampRate,recBuffer(:,m))
            xlabel('Time [s]')
            title(['Signal from microphone ' num2str(recChanList(m))])
            subplot(3,1,2)
            %plot(yf), title('Bandpass filtered signal')
            plot((1:length(yf))/sampRate,yf), title('Bandpass filtered signal')
            xlabel('Time [s]')
            subplot(3,1,3)
            xaksis=((1:length(yc))/sampRate);
            plot(xaksis,yc)
            title(['Filtered signal convoluted with pulse ' num2str(n)])
            xlabel('Time [s]')
            hold on
            for k = 1:length(pidx)
                plot(xaksis(pidx(k)),yc(pidx(k)),'d','color','r')
            end            
            hold off
            display('.........press any key to continue. N.B. the figure will be overwritten!')
            pause
        end
    end
end
TPHAT=TPHAT(1:n_pulse,:);
display(['...pulse times from ' num2str(N)...
    ' speakers found in ' num2str(M) ' microphones'])
return