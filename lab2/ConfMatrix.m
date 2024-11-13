function CM = ConfMatrix(Yte,Z)
threshold = 0.5;
Yte_class = Yte >= threshold;
Z_class = Z >= threshold;
TP = 0; TN = 0; FP = 0; FN = 0;
for i = 1:length(Yte_class)
    if Yte_class(i) == 1 && Z_class(i) == 1
        TP = TP + 1;  % True Positive
    elseif Yte_class(i) == 0 && Z_class(i) == 0
        TN = TN + 1;  % True Negative
    elseif Yte_class(i) == 0 && Z_class(i) == 1
        FP = FP + 1;  % False Positive
    elseif Yte_class(i) == 1 && Z_class(i) == 0
        FN = FN + 1;  % False Negative
    end
end

CM = [TP, FN; FP, TN];
end