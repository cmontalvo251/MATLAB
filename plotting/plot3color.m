function plot3color(x,y,z)

%%%%Generate Figure
%fig = figure();
%ax = gca;

%%%Get min and max values
minz = min(z);
maxz = max(z);

%%%Create levels
levels = linspace(minz,maxz,5);
colors = {'b','c','g','y','r'};

%%%Plot Levels
for idx = 2:length(z)
    color = find(z(idx)<=levels,1);
    plot3([x(idx-1) x(idx)],[y(idx-1) y(idx)],[z(idx-1) z(idx)],[colors{color},'-'],'LineWidth',4)
    hold on
end
view(180,90)

%%%Make colorbar
colorbar('eastoutside');
caxis([minz maxz])

%%%Make Title
%t = ['R = ',num2str(levels(5)),' Y = ',num2str(levels(4)),' G = ',num2str(levels(3)),' C = ',num2str(levels(2)),' B = ',num2str(levels(1))];

