clear all

%% Set up  
% Number of pulses per second that you want to play in speakers
npt = 2;
% time to record in seconds
time = 45;
% number of pulses that will be played
n_pulse = npt*time;
% microphone inputs to use
mics = 2:8;
% speaker outputs to use
speakers = [];
% width of sound pulse
pulseWidth = [0.001 0.005 0.01];
% frequency of pulse
pulseFreq = [1000]; 

%% Record
% List of channels that you want to play sound on, ie same as speakers
% above

playChanList = speakers;
% see help SFlabPlayAndRecord o
[recBuffer,recChanList,sampRate,soundData] = SFlabPlayAndRecord(time,...
    n_pulse,mics,speakers,pulseWidth,pulseFreq);

%% Plot the recorded data
SFlabPlotRecData(recBuffer,recChanList,...
      playChanList,soundData,sampRate)

%% Find the pulse times
% Set to 0 to turn plots off, 1 otherwise.
plotOn = 1;
% Estimate pulse times, see help SFlabFindPulseTimes

tphat = SFlabFindPulseTimes(recBuffer,recChanList,speakers,...
    sampRate,pulseFreq,pulseWidth,npt,time,plotOn,[]);
%% Listen to the recorded data
SFlabPlayRecData(recBuffer,recChanList,1)



