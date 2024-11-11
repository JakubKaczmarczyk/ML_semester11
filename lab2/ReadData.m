function [X,Y1,Y2] = ReadData()
    S = load('LC_data.mat');
    X = S.X;
    Y1 = S.Y1;
    Y2 = S.Y2;
end