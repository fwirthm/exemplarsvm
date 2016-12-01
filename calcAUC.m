
AUC = 0.0;
for IdX=1:1:size(Myresults.recall,1)

    rec_new = Myresults.recall(IdX);
    
    if IdX == 1
        rec_old = 0.0;
        prec_old = 1.0;
    else
        rec_old = Myresults.recall(IdX-1);
        prec_old = Myresults.prec(IdX-1);
    end
    
    auc = (rec_new - rec_old)*prec_old;
    AUC = AUC + auc;
end

fprintf('AUC: %d\n', AUC);
