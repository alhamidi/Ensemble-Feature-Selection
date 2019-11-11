function [acc, sen, spe, pre, fone] = Evaluate(ACTUAL,PREDICTED)
    idx = (ACTUAL()==1);

    p = length(ACTUAL(idx));
    n = length(ACTUAL(~idx));
    N = p+n;

    tp = sum(ACTUAL(idx)==PREDICTED(idx));
    tn = sum(ACTUAL(~idx)==PREDICTED(~idx));
    fp = n-tn;
%     fn = p-tp;

    tp_rate = tp/p;
    tn_rate = tn/n;

    acc = (tp+tn)/N;
    sen = tp_rate;
    spe = tn_rate;
    pre = tp/(tp+fp);
    recall = sen;
    f_measure = 2*((pre*recall)/(pre + recall));
    auc = 0.5*(recall+spe);
%     gmean = sqrt(tp_rate*tn_rate);
    acc = acc*100;
    sen = sen*100;
    spe = spe*100;
    pre = pre*100;
    fone = f_measure;
% EVAL = [acc sen spe pre auc];