%%%%Skill Assessment Exercise 4.3

%%%Part a
denom = [1 12 400]
roots(denom)
G = tf([400],denom)
step(G)

%%%Part b 
denom = [1 90 900]
roots(denom)
G = tf([900],denom)
step(G)

%%%Part C
denom = [1 30 225]
roots(denom)
G = tf([225],denom)
figure()
step(G)

%%%Part D
denom = [1 0 625]
roots(denom)
G = tf([625],denom)
figure()
step(G)

