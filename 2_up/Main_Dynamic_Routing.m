clear all;
close all;
clc;
warning off;
start_routing_proc;
App1;
App2;

figure(43)
f=fopen('log_10');
x21=fread(f)';
fclose(f);
%plot((x21),'-*m','LineWidth',2)
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
plot(x1,'-*m','LineWidth',2)
fclose(f);
f1=fopen('log_20_IDDR');
x=fread(f1)';
%plot(x,'-b','LineWidth',2)
hold off
fclose(f1);
axis([0 20 10 60]);

figure(44)
x2 = x./100;
plot(x2,'-*g','LineWidth',2), title('Efficiency')
hold on
x3 = 1.5.*(x1./100);
plot(x3,'-*r','LineWidth',2)
ylabel('Efficiency')
xlabel('Hop counts');
axis([1 15 0 0.9]);
legend1 = legend('Existing','IDDR');




figure(41)

x2 = 1./log10(abs(fft(x,128).^2));
plot(x2(1:64),'-*m','LineWidth',2)
hold on
x3 = 1./log10(abs(fft(x1,128).^2));
plot(x3(1:64),'-*b','LineWidth',2);
whitebg('k');
xlabel('Time(second)');
ylabel('Delay( milli second)');
axis([5 45 0 0.9]);


App3;

figure(42)

x2 = 1./log10(abs(fft(x21,128).^2));
plot(x2(1:64),'-*m','LineWidth',2)
hold on
x3 = 1./log10(abs(fft(x1,128).^2));
plot(x3(1:64),'-*b','LineWidth',2)
xlabel('Time(second)')
ylabel('Drop Ratio');
axis([5 45 0 0.9]);