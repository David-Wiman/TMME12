function ydot = ProjectFunction(t, y)
% Defines the ODEs derived in the TMME12 project

% pre-set variables
    g = 9.82;
    l0 = 0.45;
    b = 0.3;
    m = 0.5;
    k = 100;
    
% rename variables
    z=y(1);
    z_dot=y(2);
    
% define functions
    ydot=zeros(2,1);
    ydot(1) = z_dot;
    ydot(2) = (-k/m)*(sqrt(z^2+b^2)-l0)*sin(atan(z/b))-g;
end
