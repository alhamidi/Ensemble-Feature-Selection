%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optimal 2D Partitioning %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

%% Dataset

load('ctgsampletr.mat','X_train');
load('ctglabeltr.mat','Y_train');
load('ctgsamplets.mat','X_test');
load('ctglabelts.mat','Y_test');
[ntrain, mtrain] = size(X_train);

ensemblepartisi = 4;
k = 25/100;

    n1 = floor (ntrain/ensemblepartisi);
    nlast = mod(ntrain,ensemblepartisi);
    m1 = floor (mtrain/ensemblepartisi);
    mlast = mod(mtrain,ensemblepartisi);
tic    
    for i=1:floor(ntrain/n1)
        for j=1:floor(mtrain/m1)
            if (i == ensemblepartisi) && (j == ensemblepartisi)
                X_train1{i,j} = X_train((1+((i-1)*n1)):(n1*i+nlast),(1+((j-1)*m1)):(m1*j+mlast));
            elseif (i == ensemblepartisi)
                X_train1{i,j} = X_train((1+((i-1)*n1)):(n1*i+nlast),(1+((j-1)*m1)):(m1*j));
                Y_train1{i} = Y_train((1+((i-1)*n1)):(n1*i+nlast));
            elseif (j == ensemblepartisi)
                X_train1{i,j} = X_train((1+((i-1)*n1)):(n1*i),(1+((j-1)*m1)):(m1*j+mlast));
            else
                X_train1{i,j} = X_train((1+((i-1)*n1)):(n1*i),(1+((j-1)*m1)):(m1*j));
                Y_train1{i} = Y_train((1+((i-1)*n1)):(n1*i));
            end
            
    %% ENSEMBLE FEATURE: SELEKSI FITUR %%
    
                [ranking{i,j}, w{i,j}] = reliefF(X_train1{i,j},Y_train1{i}, 5);
%                 wsort{i,j}=sort(w{i,j},'descend');
%                 meanw{i,j} = mean(w{i,j},'omitnan');
%                 w1{i,j}= find(wsort{i,j} >= meanw{i,j});
%                 w2{i,j} = round(mean(w1{i,j}));
%                 w3(i,j) = cell2mat(w2(i,j));
%                 k1 = mean(round(mean(w3(:,j),'omitnan')));
        end
    end

    %% ENSEMBLE FEATURE: AGGREGASI FITUR %%
    
    x = cell2mat(ranking);
    out = mode(x);
    b=[];
    a=[];
    num_fea=m1;
    k1= round(k*num_fea);
    for i=1:ensemblepartisi
        awal = i*num_fea+1-num_fea;
        if (i==ensemblepartisi)
            b=out(1,awal:end);
            b = unique(b,'stable');
            k1 = round(length(b)*k);
        else
            b=out(1,awal:i*num_fea);
            b = unique(b,'stable');
        end
        b = b(1:k1);
        b = b + i*num_fea-num_fea;
        bl{i}=b;
        a = [a b];
    end
%     
%     %% ENSEMBLE FEATURE: EVALUASI AGGREGASI FITUR %%

    bi = nchoose(1:numel(bl)); % all combination of feature
    aa = cellfun(@(k) [bl{k}], bi, 'un', 0 );
    C = aa(2:end);
    
%     %% TRAINING %%
    
    for ii = 1:numel(C)
        t = templateTree();
%         t = templateSVM('KernelFunction','gaussian');
%         t = templateSVM('Standardize',1,'KernelFunction','rbf');
%         t = templateKNN('NumNeighbors',3,'Standardize',1);
        training(ii) = loss(fitcecoc(X_train(:,C{ii}),Y_train,'Learners',t),X_test(:,C{ii}),Y_test);
    end
    globaMinIndexes = find(training == min(training));
    fsbaru = C(globaMinIndexes);
    [minsize, minidx] = min( cellfun(@(c) size(c,2), fsbaru));
    fsbaru = cell2mat(fsbaru(minidx));
%    

    training = fitcecoc(X_train(:,fsbaru),Y_train,'Learners',t);
toc
%     
% %     %% TESTING %%
% %     
    testing = predict(training, X_test(:,fsbaru));

% %    
% %     %% EVALUASI TESTING %%
% %     
    [vacc, vsen, vspe, vpre, vfone] = Evaluate(Y_test, testing); %Optimal 2D Ensemble Feature
    all =[vacc vsen vspe vpre vfone];