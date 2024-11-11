function [X,mu,sig]=StdFea(X,mu,sig)
    if isempty(mu)
        mu = mean(X, 2);
    end
    if isempty(sig)
        sig = std(X, 0, 2);
    end
    % X = (X - mu) ./ sig;
    X(2:end, :) = (X(2:end, :) - mu(2:end)) ./ sig(2:end);
end