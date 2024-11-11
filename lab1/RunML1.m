clear all;
close all;

% Odczytanie danych
[X, Y] = ReadData;

% mapowanie cech
X_mapped = MapFea(X);

% standaryzacja cech
[X_standarized,mu,sig] = StdFea(X_mapped, [], []);

% podział danych na 70% treningowe, 30% testowe
ratio = [0.7,0,0.3];
[Xtr,Ytr,Xval,Yval,Xte,Yte]=SplitData(X_standarized,Y,ratio);

% wartości początkowe wektora Theta
Theta0 = rand(8, 1);

% znalezienie optymalnego wektora Theta
[ThetaOpt,JOpt] = FindTheta(Theta0,Xtr,Ytr);

% sprawdzenie zbioru testowego
[Jte,dJte] = CostFun(Xte,Yte,ThetaOpt);


% Wypisanie hipotezy
imie_nazwisko = "Jakub Kaczmarczyk";
max_iterations = 100000;
alpha = 0.1;
train_percent = 70;
test_percent = 30;
validation_percent = 0;
global iterations;

params_text = sprintf(['Jakub Kaczmarczyk' newline ...
                       'Maks liczba iteracji: %d' newline ...
                       'Uczenie zakończone po %d iteracjach' newline ...
                       'Wielkość kroku uczenia alfa: %.1f' newline ...
                       'Początkowy wektora Theta uzupełniony wartościami losowymi' newline ...
                       'Podział zbioru: uczący %d%%, testowy %d%%, walidacyjny %d%%' newline ...
                       'Uzyskany błąd na zbiorze treningowym: %.4f' newline ...
                       'Uzyskany błąd na zbiorze testowym: %.4f'], ...
                       max_iterations, iterations, alpha, ...
                       train_percent, test_percent, validation_percent, JOpt, Jte);
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
[X_grid, Y_grid] = meshgrid(unique(X_standarized(2, :)), unique(X_standarized(3, :)));
Z_grid = griddata(X_standarized(2, :), X_standarized(3, :), Y, X_grid, Y_grid, 'cubic');
Yh = (ThetaOpt.')*X_standarized;
Z_grid_h = griddata(X_standarized(2, :), X_standarized(3, :), Yh, X_grid, Y_grid, 'cubic');


subplot(2, 2, 2);
surf(X_grid, Y_grid, Z_grid, 'FaceColor', 'blue', 'EdgeColor', 'none');
hold on;
surf(X_grid, Y_grid, Z_grid_h, 'FaceColor', 'red', 'EdgeColor', 'none');
title('Wykres porównawczy', 'FontSize', 16, 'FontWeight', 'bold');

subplot(2, 2, 3);
surf(X_grid, Y_grid, Z_grid_h);
title('Wynik uczenia', 'FontSize', 16, 'FontWeight', 'bold');

subplot(2, 2, 4);
surf(X_grid, Y_grid, Z_grid);
title('Zbiór uczący', 'FontSize', 16, 'FontWeight', 'bold');