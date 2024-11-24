clear all;
close all;

[X1, Y1] = ReadData(1);
[X2, Y2] = ReadData(2);
[X3, Y3] = ReadData(3);
[X4, Y4] = ReadData(4);

sigma1 = calculateCovariance(X1);
sigma2 = calculateCovariance(X2);
sigma3 = calculateCovariance(X3);
sigma4 = calculateCovariance(X4);

[U1,S1,V1] = svd(sigma1);
[U2,S2,V2] = svd(sigma2);
[U3,S3,V3] = svd(sigma3);
[U4,S4,V4] = svd(sigma4);

n1 = analyzeEigenvalues(S1);
n2 = analyzeEigenvalues(S2);
n3 = analyzeEigenvalues(S3);
n4 = analyzeEigenvalues(S4);

[X1_mapped, X1_reconstructed] = pcaMapAndReconstruct(U1, X1, n1);
[X2_mapped, X2_reconstructed] = pcaMapAndReconstruct(U2, X2, n2);
[X3_mapped, X3_reconstructed] = pcaMapAndReconstruct(U3, X3, n3);
[X4_mapped, X4_reconstructed] = pcaMapAndReconstruct(U4, X4, n4);

error1 = norm(X1 - X1_reconstructed, 'fro') / norm(X1, 'fro') * 100;
error2 = norm(X2 - X2_reconstructed, 'fro') / norm(X2, 'fro') * 100;
error3 = norm(X3 - X3_reconstructed, 'fro') / norm(X3, 'fro') * 100;
error4 = norm(X4 - X4_reconstructed, 'fro') / norm(X4, 'fro') * 100;

disp(['Błąd rekonstrukcji X1: %%', num2str(error1)]);
disp(['Błąd rekonstrukcji X2: %%', num2str(error2)]);
disp(['Błąd rekonstrukcji X3: %%', num2str(error3)]);
disp(['Błąd rekonstrukcji X4: %%', num2str(error4)]);


set(gcf, 'WindowState', 'maximized');
sgtitle('Maksymalne wychylenie wózka w zależności od dwóch składowych głównych (PC1 i PC2)');

subplot(2, 2, 1);
PlotData(X1_mapped, Y1);
title('Zbiór danych 1');
xlabel('PC1');
ylabel('PC2');
zlabel('Maksymalne wychylenie wózka (Y)');

subplot(2, 2, 2);
PlotData(X2_mapped, Y2);
title('Zbiór danych 2');
xlabel('PC1');
ylabel('PC2');
zlabel('Maksymalne wychylenie wózka (Y)');

subplot(2, 2, 3);
PlotData(X3_mapped, Y3);
title('Zbiór danych 3');
xlabel('PC1');
ylabel('PC2');
zlabel('Maksymalne wychylenie wózka (Y)');

subplot(2, 2, 4);
PlotData(X4_mapped, Y4);
title('Zbiór danych 4');
xlabel('PC1');
ylabel('PC2');
zlabel('Maksymalne wychylenie wózka (Y)');


