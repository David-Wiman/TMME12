function [] = ProjectMain
% The main function in solving the problem presented in the TMME12 project
% David Wiman (davwi279) & Samuel Erickson Andersson (samer177)

% pre-set variables
    m = 0.5;
    k = 100;
    g = 9.81;
    b = 0.3;
    h = 1.5*sqrt(3)*b;
    l0 = 0.45;
    t_max = 3;

% stop condition
    stop_z = 0;

% run the ODE-solver with the stopping condition
    options=odeset('Events',@(t,y) ProjectEvent(t,y,stop_z),'RelTol',1e-3,...
        'AbsTol',1e-6,'MaxStep',0.01);
    [t_vek,Y] = ode45(@(t,y) ProjectFunction(t,y), [0 t_max],[h 0],options);
    z=Y(:,1);
    z_dot=Y(:,2);
    z_dot_dot = (-k/m)*(sqrt(z.^2+b^2)-l0).*sin(atan(z./b))-g;

% define s, traveled distance
    s = h-z;

% compute splat time
    splat_time_krage = t_vek(end);
    splat_time_kloss = sqrt(2*h/g);

% plot the first figure, speed over distance
    figure(1)
    p1 = plot(s,abs(z_dot));
    hold on
    p2 = plot(s,sqrt(2*g*s));
    hold off
    xlabel('Fallen sträcka, s [m]')
    ylabel('Fart, [m/s]')
    legend([p1 p2],'Kragen','Klossen','location','northeastoutside')
    
% creates the constant acceleration vector
    len = length(s);
    pre_g_vector = ones(len);
    g_vector = pre_g_vector.*-g;
    
% plot the acceleration over distance
    figure(2)
    p3 = plot(s,z_dot_dot);
    hold on
    p4 = plot(s,g_vector);
    hold off
    xlabel('Fallen sträcka, s [m]')
    ylabel('Acceleration, [m/s^2]')
    legend([p3; p4],'Kragen','Klossen','location','northeastoutside')
    
% compute normal force
    N = k.*(sqrt(z.^2+b^2)-l0).*cos(atan(z./b));
    
% plot normal force over distance
    figure(3)
    plot(s,N);
    xlabel('Fallen sträcka, s [m]')
    ylabel('Normalkraft, [N]')
    
% compute extended or shortened spring
    if N(1) < 0
        s_normal_turn_point = 0;
    else
        for i = 1:(length(N)-1)
            if N(i)*N(i+1)<=0
                s_normal_turn_point = s(i);
            end
        end
    end
    
% compute different types of energy
    T=0.5*m*z_dot.^2;
    Vg= m*g*z;
    Ve=0.5.*k.*(sqrt(z.^2+b^2)-l0).^2;
    E=T+Vg+Ve;

% plot the different energies over distance
    figure(4)
    p5 = plot(s,T);
    hold on
    p6 = plot(s,Vg);
    p7 = plot(s,Ve);
    p8 = plot(s,E);
    hold off
    legend([p5 p6 p7 p8],'Kinetisk energi','Lägesenergi', 'Fjäderenergi',...
        'Total energi','location','northeastoutside')
    xlabel('Fallen sträcka, s [m]')
    ylabel('T, Vg, Ve, E, [J]')
    
end
