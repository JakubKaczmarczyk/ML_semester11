function Sigma = calculateCovariance(X)
    mu = mean(X, 2);
    X_centered = X - mu;
    Sigma = (X_centered * X_centered') / size(X, 2);
end