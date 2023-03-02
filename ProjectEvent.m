function [value,isterminal,direction] = ProjectEvent(t,y,stop_y)
% Stopping-condition trigger for the TMME12 project

    value=y(1);
    isterminal=1;
    direction=0;   
    
end
