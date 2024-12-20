clear all;
close all;

% Odczytanie danych
[X, Y1, Y2] = ReadData;

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
[ThetaOpt1,JOpt1] = FindTheta(Theta0,X1tr,Y1tr);
[ThetaOpt2,JOpt2] = FindTheta(Theta0,X2tr,Y2tr);
% 
% sprawdzenie zbioru testowego
[J1_val,dJ1_val] = CostFun(X1val,Y1val,ThetaOpt1);
[J2_val,dJ2_val] = CostFun(X2val,Y2val,ThetaOpt2);

% wzór hipotezy
symbolic_formula = '$$y = \theta_0 + \theta_1 x_1 + \theta_2 x_2 + \theta_3 x_1^2 + \theta_4 x_2^2 + \theta_5 x_1^3 + \theta_6 x_2^3 + \theta_7 x_1 x_2$$';

set(gcf, 'WindowState', 'maximized');
sgtitle(symbolic_formula, 'Interpreter', 'latex');
subplot(2, 2, 1);
PlotData(X,Y1);
PlotBoundry(X,Y1);
title('Dane i granica decyzji dla zestawu 1');
subplot(2, 2, 2);
PlotData(X,Y2);
PlotBoundry(X,Y2);
title('Dane i granica decyzji dla zestawu 2');

Yh1 = (ThetaOpt1.')*X_ready;
Yh2 = (ThetaOpt2.')*X_ready;
subplot(2, 2, 3);
PlotData(X,Yh1);
PlotBoundry(X,Yh1);
title('Efekt regresji logistycznej dla zestawu 1');
subplot(2, 2, 4);
PlotData(X,Yh2);
PlotBoundry(X,Yh2);
title('Efekt regresji logistycznej dla zestawu 2');

% Wypisanie hipotezy
imie_nazwisko = "Jakub Kaczmarczyk";
lambda = 0.01;
alpha = 0.1;
train_percent = 70;
test_percent = 30;
validation_percent = 0;
params_text1 = sprintf(['Jakub Kaczmarczyk' newline ...
                       'Początkowy wektora Theta uzupełniony wartościami losowymi' newline ...
                       'Podział zbioru: uczący %d%%, testowy %d%%, walidacyjny %d%%' newline ...
                       'Uzyskany błąd na zbiorze treningowym Hipotezy 1: %.4f' newline ...
                       'Uzyskany błąd na zbiorze treningowym Hipotezy 2: %.4f' newline ...
                       'Uzyskany błąd na zbiorze testowym Hipotezy 1: %.4f' newline ...
                       'Uzyskany błąd na zbiorze testowym Hipotezy 2: %.4f'], ...
                       train_percent, test_percent, validation_percent, JOpt1, JOpt2, J1_val, J2_val);
disp(params_text1);


disp('Confusion Matrix for Hypothesis 1:');
disp(ConfMatrix(Yh1,Y1));

disp('Confusion Matrix for Hypothesis 2:');
disp(ConfMatrix(Yh2,Y2));

