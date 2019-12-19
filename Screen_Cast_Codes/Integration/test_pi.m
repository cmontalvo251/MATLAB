clear
clc
close all

N = 9;

error_vec = zeros(1,N);
for idx = 1:1:N
    idx
    inc = 2/(10^idx);
    %intervals = floor(1/inc);
    error_vec(idx) = mypi(inc)-pi;
end

fig = figure();
set(fig,'color','white')
set(axes,'FontSize',18)
semilogy(abs(error_vec),'LineWidth',2)
xlabel('N (dx = 2/(10^N))')
grid on
ylabel('|E|')