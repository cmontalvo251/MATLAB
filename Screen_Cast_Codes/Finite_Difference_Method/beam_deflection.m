%%%1 - D Beam Deflection with Finite Difference Method

%%% E*A * d^2 u / dx^2 = P(x)

E = 200e9;
A = 0.1;
dx = 2;
L = 10;
P = 1000;
N = 6;

%%%Discretize the bar
x = linspace(0,L,N);
u = zeros(1,N);

%%%%%Apply the Boundary Conditions
u(1) = 0;
u(end) = 0;

%u_unknowns = u(2:end-1);

%(E*A/dx^2) * (u(i+1) - 2*u(i) + u(i-1)) = P(xi)

lambda = (E*A)/dx^2;

% if i = 2 
% u(3) - 2*u(2)  = P(1)/lambda - u(1)
% u(4) - 2*u(3) + u(2) = P(2)/lambda

%RHS
RHS = zeros(N-2,1);
for i = 1:N-2
   RHS(i) = P/lambda; 
end
%%Apply boundary conditions
RHS(1) = RHS(1) - u(1);
RHS(end) = RHS(end) - u(end);

%Stiffness matrix
stiffness = -2*eye(N-2,N-2);
for i = 1:N-2
    if i < N-2
        stiffness(i,i+1) = 1;
    end
    if i > 1
        stiffness(i,i-1) = 1;
    end
end

%%%Solve for Unknowns
u_unknowns = stiffness\RHS;

%%%Put back into u
%u_unknowns = u(2:end-1);
u(2:end-1) = u_unknowns;

plot(x,u)


