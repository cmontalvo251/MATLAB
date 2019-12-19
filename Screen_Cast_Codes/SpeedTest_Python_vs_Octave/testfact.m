clear
clc
close all
for idx = 1:1000
    tic
    fortorial(1000);
    myfactime(idx) = toc;
    tic
    factorial(1000);
    builtintime(idx) = toc;
    
end    

for idx = 1:1000
   system('rm PythonTime.txt');
   system('./factorial.py');
   pythontime(idx) = dlmread('PythonTime.txt');
end
   

plot(myfactime,'LineWidth',2)
hold on
plot(builtintime,'r--','LineWidth',2)
grid on
plot(pythontime,'g-.','LineWidth',2)
legend('James','Builtin','Python')