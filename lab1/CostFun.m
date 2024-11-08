function [J,dJ]=CostFun(X,Y,Theta)
    lambda = 0.01;
    m =size(X,2);
    % X(w,k), Y(1,k), Theta(w,1)
    % (1,w)*(w,k) = (1,k)
    Yh = (Theta.')*X;
    err = (Yh - Y);

    % % bez regularyzacji
    % J = sum(err.^2)/(2*m);
    % % (w,k) * (k,1) = (w,1)
    % dJ =sum(X*(err.'),2)./m;
    
    % z regularyzacją
    J = (sum(err.^2) + lambda*(sum(Theta(2:end).^2)))/(2*m);
    % zastąpienie Theta0 = 0 aby nie regularyzować
    Theta(1) = 0;
    % % (w,k) * (k,1) = (w,1)
    dJ =sum(X*(err.'),2)./m + lambda/m*Theta;
    
    % % Sprawdzenie gradientu funkji numerycznie
    % NumdJ = NumGrad(X,Y,Theta);
    
    
end