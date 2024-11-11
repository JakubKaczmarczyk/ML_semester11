function [J,dJ]=CostFun(X,Y,Theta)
    % X(w,k)
    % Y(1,k)
    % Theta(w,1)
    m =size(X,2);

    % (1,w)*(w,k) = (1,k)
    Yh = sigmoid(-1.*((Theta.')*X));

    % (1,k)*(k,1) + (1,k)*(k,1) = (1,1)+(1,1)
    J = (-1/m)*(Y*(log(Yh)') + (1-Y)*(log(1-Yh)'));
    % (w,k) * (k,1) = (w,1)
    dJ =sum(X*((Yh-Y)'),2)./m;
        
    
end