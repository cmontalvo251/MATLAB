clear
clc
close all
Y = zeros(5,1);
X = 1:5;
add = 0;
num = 1;
for idx = 1:length(X)
  Y(idx) = num;
  temp = num;
  num = num + add;
  add = temp;
end
f = figure();
set(f,'color','white')
hold on
grid on
xlabel('Iteration Number')
ylabel('________ Number')
xlim([1 5])
ylim([0 5])

