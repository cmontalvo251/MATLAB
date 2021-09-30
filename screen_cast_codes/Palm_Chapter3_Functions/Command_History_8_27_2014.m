cd 8_27_2014\
ls
cd ../8_25_2014/
ls
edit homework2
exp(1)
ln()
log(0)
log(1)
log10(1)
log(10)
log10(10)
log2(2)
516^(1/6)
cos()
sinh()
atan
acos
edit PolyFun
x = [2 4 5 8+9i 8-9i 15 -3 -3+4i -3-4i]
num_roots = length(x)
y = zeros(1,num_roots)
plot(x,y)
plot(x,y,'bo')
x
im = imag(x)
x
format short
x
format short g
x
format long g
x
format long
x
format short
x
im = imag(x)
location
location = find(im == 0)
im == 0
im = imag(x)
im == 0
location = find(im == 0)
x
x(1)
x(2)
x(location)
edit importfun.m
rand
hist(rand(1000,1))
hist(randn(1000,1))
rand(5,5)
importfun
ls
importfun
help fprintf
importfun
A
importfun
all
data
txt
whos
all(1,1)
all(2,1)
whos
ex_cell = all(2,1)
ex_num = all{2,1}
whos
ex_cell + 2
ex_num + 2
clear
ls
header = {'Num 1','Num 2','Num 3'}
whos
A = rand(3,3)
A_cell = {A}
whos
A_cell = {'Cars','Speed'}
A_cell = [A_cell;{'Honda',125}]
A_ex = {A_cell;{'Honda',125}}