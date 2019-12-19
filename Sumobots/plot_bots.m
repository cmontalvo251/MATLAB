function out = plot_bots(t,botarray)

engine_settings;

n = numel(botarray);

cla
hold on
axis(world_radius(0)*[-1 1 -1 1]);
axis square

psi = linspace(0,2*pi,180);

plot(world_R*cos(psi),world_R*sin(psi),'k','LineWidth',4);

for i = 1:n
    x = botarray{i}.state(1);
    y = botarray{i}.state(2);
    color = botarray{i}.color;
    plot(x+bot_R*cos(psi),y+bot_R*sin(psi),color,'LineWidth',2)
    plot(0,0,'k.')
    % Construct an array of bots
    c = 0;
    for j = 1:n
        if j~=i
            c = c+1;
            newbotarray{c} = botarray{j};
            % Remove function handle
            newbotarray{c}.fun = [];

        end
    end
    try
    % Call the bot function
    u = feval(botarray{i}.fun,  t, botarray{i}.state , newbotarray );

    % Control saturation
    if norm(u)>u_max
        u = u/norm(u)*u_max;
    end
    
    h = atan2(u(2),u(1))+pi;
    
    plot( x+bot_R*cos(h)+[0 -u(1)/u_max*u_tail] , y+bot_R*sin(h)+[0 -u(2)/u_max*u_tail], color ,'LineWidth',3)
    end
end

drawnow
