clear all;
close all;
clc;
warning off;

App1;

App3;


App2;
figure(51)
f=fopen('log_10');
x21=fread(f)';
fclose(f);
plot((x21),'-*r','LineWidth',2)
xlabel('No of Nodes')
ylabel('Packets Tx-RX')
title('Payload : Throughtput vs No of Node')
hold on
f1=fopen('log_10_IDDR');
x=fread(f1)';
plot(x,'-+b','LineWidth',2)
fclose(f1);
f=fopen('log_20');
x1=fread(f)';
plot(x1,'-*g','LineWidth',2)
fclose(f);
f1=fopen('log_20_IDDR');
x=fread(f1)';
plot(x,'-+r','LineWidth',2)
hold off
fclose(f1);
axis([0 100 10 60]);

figure(40)
x2 = 1./log10(abs(fft(x,128).^2));
plot(x2(1:64),'-*g','LineWidth',2)
hold on
x3 = 1./log10(abs(fft(x1,128).^2));
plot(x3(1:64),'-*r','LineWidth',2)
xlabel('Time(second)')
ylabel('Delay(second)');
axis([5 45 0 0.9]);

figure(41)
x2 = 1./log10(abs(fft(x21,128).^2));
plot(x2(1:64),'-*g','LineWidth',2)
hold on
x3 = 1./log10(abs(fft(x1,128).^2));
plot(x3(1:64),'-*r','LineWidth',2)
xlabel('Time(second)')
ylabel('Drop Ratio');
axis([5 45 0 0.9]);