function Xout = MapFea(Xin)
    X_square = Xin.^2;
    X_cubic = Xin.^3;
    X_mix = Xin(1,:).*Xin(2,:);
    Xout = [ones(1, size(Xin,2)); Xin; X_square;X_cubic;X_mix;];
end