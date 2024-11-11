clear all;
close all;

% Odczytanie danych
[X, Y1, Y2] = ReadData;

% % mapowanie cech
% X_mapped = MapFea(X);
% % standaryzacja cech
% [X_standarized,mu,sig] = StdFea(X_mapped, [], []);
% X_ready = X_standarized;

% standaryzacja cech
[X_standarized,mu,sig] = StdFea(X, [], []);
% mapowanie cech
X_mapped = MapFea(X_standarized);
X_ready = X_mapped;

% podział danych na 70% treningowe, 30% testowe
ratio = [0.7,0.3,0];
[X1tr,Y1tr,X1val,Y1val,X1te,Y1te]=SplitData(X_ready,Y1,ratio);
[X2tr,Y2tr,X2val,Y2val,X2te,Y2te]=SplitData(X_ready,Y2,ratio);

% wartości początkowe wektora Theta
Theta0 = rand(8, 1);

% znalezienie optymalnego wektora Theta
[ThetaOpt01,JOpt01] = FindTheta(Theta0,X_ready,Y1);
[ThetaOpt02,JOpt02] = FindTheta(Theta0,X_ready,Y2);
% [ThetaOpt1,JOpt1] = FindTheta(Theta0,X1tr,Y1tr);
% [ThetaOpt2,JOpt2] = FindTheta(Theta0,X2tr,Y2tr);
% 
% % sprawdzenie zbioru testowego
% [J1_val,dJ1_val] = CostFun(X1val,Y1val,ThetaOpt1);
% [J2_val,dJ2_val] = CostFun(X2val,Y2val,ThetaOpt2);


PlotData(X,Y1);
PlotData(X,Y2);

Yh1 = (ThetaOpt01.')*X_ready;
Yh2 = (ThetaOpt02.')*X_ready;
PlotData(X,Yh1);
PlotData(X,Yh2);

% Wypisanie hipotezy
imie_nazwisko = "Jakub Kaczmarczyk";
max_iterations = 1000000;
lambda = 0.01;
alpha = 0.1;
train_percent = 70;
test_percent = 30;
validation_percent = 0;

params_text = sprintf(['Jakub Kaczmarczyk' newline ...
                       'Maks liczba iteracji: %d' newline ...
                       'Współczynnik regularyzacji lambda: %.2f' newline ...
                       'Wielkość kroku uczenia alfa: %.1f' newline ...
                       'Podział zbioru: uczący %d%%, testowy %d%%, walidacyjny %d%%' newline ...
                       'Uzyskany błąd na zbiorze treningowym: %.4f' newline ...
                       'Uzyskany błąd na zbiorze testowym: %.4f'], ...
                       max_iterations, lambda, alpha, ...
                       train_percent, test_percent, validation_percent, JOpt, J_val);
disp(params_text);

