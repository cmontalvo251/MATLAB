clear
clc
close all


actual = 5^3/3;

n = 0:5;
abs_error = zeros(length(n),1);

for idx = 0:(length(n)-1)
    idx
    N = 10^n(idx+1);
    computed = integral(N);
    abs_error(idx+1) = computed-actual;
end

semilogy(n,abs_error)
xlabel('n (10^n)')
ylabel('log(Abs Error)')
