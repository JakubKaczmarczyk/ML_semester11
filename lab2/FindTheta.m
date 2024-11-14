function [ThetaOpt,JOpt] = FindTheta(Theta0,X,Y)
    [x,fval,exitflag,output,grad,hessian] = fminunc(@(t) CostFun(X,Y,t), Theta0, optimoptions('fminunc', 'GradObj', 'on'));
    ThetaOpt = x;
    JOpt = fval;
end