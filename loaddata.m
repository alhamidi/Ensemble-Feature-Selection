%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Load Data %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

addpath(genpath('drtoolbox'))
addpath(genpath('functions'))

%% Dataset
% data=load('dataset01\mnistdata.txt', 'r');
% class=load('dataset01\mnistlabel.txt', 'r');
% load('dataset01\TOX_171.mat')
load('dataset01\USPS.mat')
% load('dataset01\Yale.mat')
% load('dataset01\Prostate_GE.mat')
% load('dataset01\GLI_85.mat')
% load('dataset01\lymphoma.mat')
% load('dataset01\SMK_CAN_187.mat')

% load('dataset01\tumorsY.mat')
% data = X;
% class = Y;
% 
% %% Normalisasi
% norm_data = (data - min(data(:))) ./ ( max(data(:)) - min(data(:)));
% [n, m] = size(norm_data);
% 
% %% Training
% %% CrossValidation
% partition = 0.3;
% cv = cvpartition(class,'holdout', partition);
% X_train = double(norm_data(cv.training,:) );
% Y_train = (double(class(cv.training))); % labels: neg_class -1, pos_class +1
% [ntrain, mtrain] = size(X_train);
% X_test = double(norm_data(cv.test,:));
% Y_test = (double(class(cv.test))); % labels: neg_class -1, pos_class +1
% [ntest, mtest] = size(X_test);
% % jklas = {'go','bo','ro','ko','co','mo','gs','bs','rs','ks','cs','ms','g*','b*','r*','k*','c*','m*','gd','bd'};
% % 
% % [score,latent]=pca(X_train,3);
% % score = (score - min(score(:))) ./ ( max(score(:)) - min(score(:)));
% 
% % for i=1:100
% %     [label_kmeans, center] = litekmeans(X_train,2,'MaxIter', 200);
% %     acc_kmeans(i)=accuracy(Y_train,label_kmeans);
% % end
% 
% % figure;
% % for i=1:ntrain
% %     plot3(score(i,1),score(i,2),score(i,3),jklas{Y_train(i)})
% %     hold on
% %     grid on
% % end
% save('tumor9sampletr.mat','X_train');
% save('tumor9slabeltr.mat','Y_train');
% save('tumor9ssamplets.mat','X_test');
% save('tumor9slabelts.mat','Y_test');