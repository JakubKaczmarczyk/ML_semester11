function [Xtr,Ytr,Xval,Yval,Xte,Yte]=SplitData(X,Y,ratio)
    col_size = size(X,2);
    num_cols = round(ratio * col_size);
    num_cols(1) = col_size - sum(num_cols(2:3));
    col_perm = randperm(col_size);

    idx1 = col_perm(1:num_cols(1));
    idx2 = col_perm(num_cols(1)+1:num_cols(1)+num_cols(2));
    
    Xtr =  X(:, idx1);
    Xval = X(:, idx2);
    Ytr =  Y(:, idx1);
    Yval = Y(:, idx2);
    
    Xte = [];
    Yte = [];
    if num_cols(3) > 0
        idx3 = col_perm(num_cols(1)+num_cols(2)+1:end);
        Xte =  X(:, idx3);
        Yte =  Y(:, idx3);
    end
end