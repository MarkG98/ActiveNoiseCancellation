clear
[l, Fs] = audioread('cheezits.wav');

inp = l(:,2);
d = l(:,1);
%%
inp = (inp - ones(size(inp))*mean(inp));
d = (d - ones(size(d))*mean(d));

a = LMSFilter(0.016,600);
[y, e, w] = a.lms(inp,d);

res = d-y';

%%
figure
subplot(1,2,1)
plot((1:1:size(d,1))./Fs,d,'r')
title('Speech With White Noise')
xlabel('Time (s)')
ylabel('Amplitude')
ylim([-2,1.5])
subplot(1,2,2)
plot((1:1:size(d,1))./Fs,res,'b')
title('Filtered Speech')
xlabel('Time (s)')
ylabel('Amplitude')
ylim([-2,1.5])