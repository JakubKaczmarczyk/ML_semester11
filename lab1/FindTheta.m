function [ThetaOpt,JOpt] = FindTheta(Theta0,X,Y)
    alpha = 0.1;
    n = 1000000;
    acceptanceJ = 0.0001;
    Theta = Theta0;
    i = 0;
    while i < n
        [J,dJ]=CostFun(X,Y,Theta);
        if J < acceptanceJ
            break
        end
        Theta = Theta - alpha*dJ;
        i = i+1;
    end
    ThetaOpt = Theta;
    JOpt = J;
    % disp(i)
    % disp(JOpt)
end