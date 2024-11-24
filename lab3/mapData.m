function [X_mapped, X_reconstructed] = pcaMapAndReconstruct(U, X, n)
    U_reduced = U(:, 1:n)';
    X_mapped = U_reduced * X;
    X_reconstructed = U(:, 1:n) * X_mapped;
end