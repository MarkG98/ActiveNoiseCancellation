clear
[l, Fs] = audioread('cheezits.wav');

inp = l(:,2);
d = l(:,1);

inp = (inp - ones(size(inp))*mean(inp));
d = (d - ones(size(d))*mean(d));


totallength = size(d,1);

% channel system order
sysorder = 600;
%Take 60 points for training
N=352800;

thresh = 0.3;

%begin of algorithm
w = zeros ( sysorder , 1 ) ;
%
for n = sysorder : N
    u = inp(n:-1:n-sysorder+1);
    y(n)= w' * u;
    e(n) = d(n) - y(n);
    
    avg(n) = mean(abs(d(n:-1:n-sysorder+1)));
    if avg(n) < thresh 
        mu = 0.014;
    else
        mu = 0.002;
    end
    w = w + mu * u * e(n);
end
%
res = d-y';
time = linspace(0,8,352800);

%
figure
subplot(1,2,1)
plot(time,d,'r')
title('Unfiltered Signal');
ylabel('Amplitude')
xlabel('Time (s)');
subplot(1,2,2)
plot(time,res,'b')
title('Filtered Signal With Speech Detection');
ylabel('Amplitude')
xlabel('Time (s)');

%%
clear
[l, Fs] = audioread('cheezits.wav');

inp = l(:,2);
d = l(:,1);

inp = (inp - ones(size(inp))*mean(inp));
d = (d - ones(size(d))*mean(d));

N=352800;
sysorder = 600;
thresh = 0.25;

%begin of algorithm
w = zeros ( sysorder , 1 ) ;
%
for n = sysorder : N
    %u = inp(n:-1:n-sysorder+1);
    %freq = fftshift(abs(fft(d(n:-1:n-sysorder+1))));
    %window = linspace(n,n-sysorder+1,sysorder);
    avg(n) = mean(abs(d(n:-1:n-sysorder+1)));

    %arithmetic = mean(freq);
    %geometric = geomean(freq);

    %flatness(n) = 10.*log(geometric./arithmetic);
    %y(n)= w' * u;
    %e(n) = d(n) - y(n);
    %mu=0.014;
    %w = w + mu * u * e(n);
end
%%
figure 
hold on
plot(d,'b')
%plot((flatness - ones(size(flatness))*mean(flatness)),'r')
plot(avg,'r')
xlabel('Sample')
ylabel('Amplitude')
legend('Noisy Speech Signal','Mean Amplitude')
title('Difference in Mean Amplitude Between Noise and Speech Windows')

hold off
%freq = fftshift(abs(fft(d(n:-1:n-sysorder+1))));
%window = linspace(n,n-sysorder+1,sysorder);

%arithmetic = mean(freq);
%geometric = geomean(freq);

%flatness = geometric./arithmetic;

%figure
%hold on
%plot(d,'b')
%plot(window,d(n:-1:n-sysorder+1),'r')
%hold off
