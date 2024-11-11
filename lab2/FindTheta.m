function [ThetaOpt,JOpt] = FindTheta(Theta0,X,Y)
    alpha = 0.5;
    n = 1000000;
    Theta = Theta0;
    i = 0;
    mindJ = 0.0001;
    while i < n
        [J,dJ]=CostFun(X,Y,Theta);
        if norm(dJ) < mindJ
            break
        end
        Theta = Theta - alpha*dJ;
        i = i+1;
    end
    ThetaOpt = Theta;
    JOpt = J;
    global iterations;
    iterations = i;
    % disp(i)
    % disp(JOpt)
end