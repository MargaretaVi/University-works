function [recBuffer,recChanList,sampRate,soundData] = ...
    SFlabPlayAndRecord(time,n_pulse,mics,speakers,pulseWidth,pulseFreq)
%
% Function that plays a sound and records at the same time.
%
% function [recBuffer,recChanList,noiseBuffer,sampRate,soundData] = ...
%     SFlabPlayAndRecord(time,n_pulse,mics,speakers,pulseWidth,pulseFreq)
%
% INPUTS:
% time        -  Length in seconds of the recording.
% n_pulse     -  Number of pulses.
% mics        -  Vector that specifies which microphones to use,
%                e.g. mics=[1:8] means microphones 1 to 8 are used.
% speakers    -  Vector that specifies which speakers to use,
%                e.g. speakers=[1:8] means speakers 1 to 8 are used.
% pulseWidth  -  Width of the pulses.
% pulseFreq   -  Pulse frequency.
%
% OUTPUTS:
% recBuffer   -  NxM-matrix with sound data, where M=length(mics) and
%                N = (sample freq)*(time). Each column contains data from
%                one of the microphones.
% recChanList -  Vector with the recording channels that were used.
% sampRate    -  Sampling frequency.
% soundData   -  Sound sequence that was played.
%
%

% Martin Skoglund and Karl Granström
% 2009-02-24

%  Get information on all available devices
dL = playrec('getDevices');
% Get correct device ID
% name should be "Saffire PRO ASIO Driver"
nameList = {dL.name};
devID = [];
for i = 1:length(nameList)
    if strcmp(nameList{i}, 'Saffire Pro26 1394 ASIO x64')
   % if strcmp(nameList{i}, 'Saffire PRO ASIO Driver')
        devID = dL(i).deviceID; % Get device ID
        sampRate = dL(i).defaultSampleRate; % Get sample rate
    end
end

if isempty(devID)
    display('No device found - aborting')
    return
end

% initialise playrec functions
% sample rate, play device id, rec device id, max play ch, max rec ch
if ~playrec('isInitialised')
    playrec('init',sampRate,devID,devID,1,8);
end

display('Press any key to start recording.')
pause
display('Recording...')
if ~isempty(speakers)
    % create sound data
    display('...generating sound.')
    soundData = generateSoundData(time,n_pulse,pulseWidth,pulseFreq,sampRate);
    display('...sound generated.')
    % play the sound and record from microphones
    % input: sound to be played, channels to play at, number of samples to
    % record, channels to record at.
    [pageNumber] = playrec('playrec',soundData,speakers,sampRate*time,mics);
else
    soundData = 0;
    % record from microphones
    % input: number of samples to record, channels to record at.
    [pageNumber] = playrec('rec',sampRate*time,mics);
end

% wait for playrec to finish recording
while(playrec('isFinished',pageNumber) == 0); end
display('...play and record session finished.')

% get recorded data

[recBuffer, recChanList] = playrec('getRec',pageNumber);
recBuffer = double(recBuffer);
