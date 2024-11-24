function [num_significant] = analyzeEigenvalues(S)
    eigenvalues = diag(S);
    total_sum = sum(eigenvalues);
    contributions = (eigenvalues / total_sum) * 100;
    num_significant = sum(contributions > 1);
end