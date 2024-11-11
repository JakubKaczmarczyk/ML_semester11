clear all;
close all;
function Xout = MapFea(Xin)
    X_square = Xin.^2;
    X_cubic = Xin.^3;
    Xout = [ones(1, size(Xin,2)); Xin; X_square;X_cubic;Xin.^4;];
    % Xout = [ones(1, size(Xin,2)); Xin;X_square];
end

function Xout = NormalizeX(X)
    minX = min(X, [], 2);  % Minimalna wartość w każdym wierszu (wzdłuż 2-go wymiaru)
    maxX = max(X, [], 2);  % Maksymalna wartość w każdym wierszu (wzdłuż 2-go wymiaru)

    % Normalizacja każdego wiersza
    Xout = (X - minX) ./ (maxX - minX);  % Zastosowanie wzoru na normalizację
    % Xout(1,:) = X(1,:);
end

function [X,mu,sig]=StdFea1(X,mu,sig)
    if isempty(mu)
        mu = mean(X, 2);
    end
    if isempty(sig)
        sig = std(X, 0, 2);
    end
    X(2:end, :) = (X(2:end, :) - mu(2:end)) ./ sig(2:end);
    % X = (X - mu) ./ sig;
end

function [X,mu,sig]=StdFea2(X,mu,sig)
    if isempty(mu)
        mu = mean(X, 2);
    end
    if isempty(sig)
        sig = std(X, 0, 2);
    end
    % X(2:end, :) = (X(2:end, :) - mu(2:end)) ./ sig(2:end);
    X = (X - mu) ./ sig;
end


X=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]+3000;
Y=[1,3,5,6,6,5.5,5,4.5,2,0,-2,-2.5,-2.9,-3,-4,-5,-5,-5,-5,-4];
% Y=[1,1,1,1,1.1,1.2,1.2,1.5,1.7,1.8,1.85,1.9,2,2,2,2,2,2,2,2];
figure;
plot(X,Y);
hold on;
% X_normalized = NormalizeX(X);
% X_normalized = X;

X_mapped = MapFea(X);
[X_standarized,mu,sig] = StdFea1(X_mapped, [], []);
Xready = X_standarized;

% [X_standarized,mu,sig] = StdFea2(X, [], []);
% X_mapped = MapFea(X_standarized);
% Xready = X_mapped;

Theta0 = zeros(5,1);
[ThetaOpt,JOpt] = FindTheta(Theta0,Xready,Y);

Yh = ThetaOpt.'*Xready;
plot(X,Yh);