function [NumdJ] = NumGrad(X,Y,Theta)
    lambda = 0.01;
    m =size(X,2);
    diff_step = 0.0001;
    NumdJ = ones(size(Theta));

    for i = 1:length(Theta)
        Theta_low = Theta;
        Theta_high = Theta;

        Theta_low(i) = Theta(i)-diff_step;
        Theta_high(i) = Theta(i)+diff_step;
        Yh_low = (Theta_low.')*X;
        err_low = (Yh_low - Y);
        Jlow = (sum(err_low.^2) + lambda*(sum(Theta_low(2:end).^2)))/(2*m);
    
        Yh_high = (Theta_high.')*X;
        err_high = (Yh_high - Y);
        Jhigh = (sum(err_high.^2) + lambda*(sum(Theta_high(2:end).^2)))/(2*m);
        NumdJ(i) = (Jhigh-Jlow)/(2*diff_step);
    end
end