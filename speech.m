% Record a speech sample
duration = 3; % Duration of recording in seconds
fs = 16000; % Sampling frequency
try
    recObj = audiorecorder(fs, 16, 1); % Create a recorder object
catch
    error('Failed to create audiorecorder object. Make sure your microphone is connected and try again.');
end
disp('Start speaking.')
recordblocking(recObj, duration); % Record speech
disp('End of recording.');
% Play back the recording
play(recObj);
% Get the recorded speech data
speechData = getaudiodata(recObj);
% Calculate the time vector
time = (0:length(speechData)-1) / fs;
% Plot the waveform
figure;
subplot(2,1,1);
plot(time, speechData);
title('Recorded Speech Waveform');
xlabel('Time (s)');
ylabel('Amplitude');
% Compute the FFT
N = length(speechData);
frequencies = (0:N-1) * fs / N;
speech_fft = fft(speechData);
speech_fft_abs = abs(speech_fft);
% Plot the frequency spectrum
subplot(2,1,2);
plot(frequencies, 20*log10(speech_fft_abs));
title('Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0, fs/2]);
% Perform speech recognition using built-in function
% Example: Recognizing the spoken digits
try
    digitsModel = speechClient('Microsoft','locale','en-US');
    recognizedText = recognizeSpeech(digitsModel, speechData, fs);
    disp('Recognized Text:');
    disp(recognizedText);
catch
    error('Failed to perform speech recognition. Make sure you have the required toolbox installed and configured properly.');
end