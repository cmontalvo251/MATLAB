%% bully - Chris Wellons
%%   Rush a target while compensating for the current velocity.
function a = bully(t,state,botarray)

% gather state info
x = state(1);
y = state(2);
v = [state(3) state(4)];

% target selection - target nearest bot
first = 1;
for bot = botarray
  bot = bot{1};
  dist = norm([bot.state(1)-x bot.state(2)-y]);
  if first || (dist < best)
    target = bot;
    best = dist;
    first = 0;
  end
end

% Gather target info
tx = target.state(1);
ty = target.state(2);

%% accelerate towards target

% current velocity unit vector
uv = unitvec(v); % unit vector velocity

% desired velicity
des_v = [(tx - x) (ty - y)];
des_uv = unitvec(des_v);

% required acceleration
gain = 25;
a = [1.25 * des_uv - uv]' * gain;
end


%% Return unit vector with divide-by-zero checks
function v = unitvec(v)
if sum(v) 
  v = v/norm(v);
end
end