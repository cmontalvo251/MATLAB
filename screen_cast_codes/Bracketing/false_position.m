function false_position()

t1 = 4; %%%Upper bound
f1 = myfunc(t1);
t2 = 0; %%%Lower bound
f2 = myfunc(t2);

t = linspace(t2,t1,100);
f = myfunc(t);
fig = figure();
plot(t,f)
hold on
set(fig,'color','white')
grid on

error = 10; %%Initial error is big

iter = 0;

tr_vec = [];

while error > 1e-4
    iter = iter + 1;
    plot([t2 t1],[f2 f1],'r--')
    %%%False Position Loop
    tr = t2 - f2*(t1-t2)/(f1-f2);
    tr_vec(iter) = tr;
    %%%Re-evaluate f at tr
    fr = myfunc(tr);
    if sign(fr) == sign(f1)
        t1 = tr;
        f1 = fr;
    else
        t2 = tr;
        f2 = fr;
    end
    %%%Recompute our error
    error = abs(fr);
end

tr
figure()
plot(tr_vec)
function out = myfunc(in)

out = in.^2-5;