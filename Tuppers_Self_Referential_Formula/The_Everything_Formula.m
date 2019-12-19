purge

x = 0:105;
k = bin2dec('1111111111111111111111111111111111111111111111111111')*17;
y = k:(k+16);

z = zeros(length(y),length(x));
figure()
for idx = 1:length(x)
  xi = x(idx);
  for jdx = 1:length(y)
    yj = y(jdx);
    val = floor(mod(floor(yj/17)*2^(-17*floor(xi)-mod(floor(yj),17)),2));
    if val > 0.5
      rectangle('Position',[xi yj-min(y) 1 1],'FaceColor','r')
      hold on
    end
  end
end

axis equal
y = y - min(y);
ylim([min(y) max(y)])
xlim([0 106])
