clear all;
close all;

% Odczytanie danych
[X, Y] = ReadData;

% standaryzacja cech
[X_standarized,mu,sig] = StdFea(X, [], []);

% mapowanie cech
X_mapped = MapFea(X_standarized);

% podział danych na 70% treningowe, 30% walidacyjne
ratio = [0.7,0.3,0];
[Xtr,Ytr,Xval,Yval,Xte,Yte]=SplitData(X_mapped,Y,ratio);

% wartości początkowe wektora Theta
Theta0 = zeros(8, 1);

% znalezienie optymalnego wektora Theta
[ThetaOpt,JOpt] = FindTheta(Theta0,Xtr,Ytr);

% sprawdzenie zbioru testowego

[J_val,dJ_val] = CostFun(Xval,Yval,ThetaOpt);


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

% display plots
set(gcf, 'WindowState', 'maximized');
subplot(2, 2, 1);

symbolic_formula = '$$y = \theta_0 + \theta_1 x_1 + \theta_2 x_2 + \theta_3 x_1^2 + \theta_4 x_2^2 + \theta_5 x_1^3 + \theta_6 x_2^3 + \theta_7 x_1 x_2$$';

numerical_formula = sprintf('$$y = %.2f + %.2f x_1 + %.2f x_2 + %.2f x_1^2 + %.2f x_2^2 + %.2f x_1^3 + %.2f x_2^3 + %.2f x_1 x_2$$', ...
    ThetaOpt(1), ThetaOpt(2), ThetaOpt(3), ThetaOpt(4), ThetaOpt(5), ThetaOpt(6), ThetaOpt(7), ThetaOpt(8));

title('Hipoteza', 'FontSize', 16, 'FontWeight', 'bold');
annotation('textbox', [0.1, 0.75, 0.8, 0.1], 'String', symbolic_formula, 'Interpreter', 'latex', 'FontSize', 14, ...
           'EdgeColor', 'none', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
annotation('textbox', [0.1, 0.65, 0.8, 0.1], 'String', numerical_formula, 'Interpreter', 'latex', 'FontSize', 14, ...
           'EdgeColor', 'none', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
axis off;


% przygotowanie danych wykresów 3D
[Xtr_grid, Ytr_grid] = meshgrid(unique(Xtr(2, :)), unique(Xtr(3, :)));
Ztr_grid = griddata(Xtr(2, :), Xtr(3, :), Ytr, Xtr_grid, Ytr_grid, 'cubic');
Yh = (ThetaOpt.')*Xtr;
Z_grid_h = griddata(Xtr(2, :), Xtr(3, :), Yh, Xtr_grid, Ytr_grid, 'cubic');


subplot(2, 2, 2);
surf(Xtr_grid, Ytr_grid, Ztr_grid, 'FaceColor', 'blue', 'EdgeColor', 'none');
hold on;
surf(Xtr_grid, Ytr_grid, Z_grid_h, 'FaceColor', 'red', 'EdgeColor', 'none');
title('Wykres porównawczy', 'FontSize', 16, 'FontWeight', 'bold');

subplot(2, 2, 3);
surf(Xtr_grid, Ytr_grid, Z_grid_h);
title('Wynik uczenia', 'FontSize', 16, 'FontWeight', 'bold');

subplot(2, 2, 4);
surf(Xtr_grid, Ytr_grid, Ztr_grid);
title('Zbiór uczący', 'FontSize', 16, 'FontWeight', 'bold');