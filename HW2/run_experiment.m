clear all;
clc;
close all;
load spamData
%%  Standard transfomation
disp('standard data transformation');
[std_Xtrain] = transform_std(Xtrain);
[std_Xtest] = transform_std(Xtest);
%%  Log transfomation
disp('log data transformation');
[log_Xtrain] = transform_log(Xtrain);
[log_Xtest] = transform_log(Xtest);
%% Create balanced cross validation folds.
N = sum(ytrain==0);
K= 5;
Indices= zeros(size(ytrain));
Indices0 = crossvalind('Kfold', N, K);
Indices(ytrain==0)=Indices0;
N = sum(ytrain==1);
Indices1 = crossvalind('Kfold', N, K);
Indices(ytrain==1)=Indices1;
%% Cross validation to select the best lambda for logit + standard
% for std 
disp('Cross validation to select the best lambda for logit + standard');
lambda = 2.^[-15:5];
eta = 0.00001;
eps = 1e-3;
max_itr = 10000;
bestlambda = 0;
bestacc = 0;
for itr1 = 1:length(lambda)
    disp(['lambda:' num2str(lambda(itr1))]);
    % train and test
    acc1 = [];
    for itr2 = 1:5
        % prepare data
        XXvalid  = std_Xtrain((Indices==itr2),:);
        yyvalid  = ytrain((Indices==itr2),:);
        
        XXtrain = std_Xtrain((Indices~=itr2),:);
        yytrain = ytrain((Indices~=itr2),:);
        
        w0 = rand(size(Xtrain,2)+1,1);
        [w, loglike] = train_lr(XXtrain,yytrain,w0,eps,lambda(itr1),eta,max_itr);
        % test it
        [ypred,tp,tn,fp,fn] = test_lr(XXvalid,yyvalid,w);
        acc1 = [acc1 (tp+tn)/(tp+fp+fn+tn)];
    end
    acc = mean(acc1);
    
    if (acc>bestacc)
        bestlambda = lambda(itr1);
        bestacc = acc;
        disp(['Best lambda/Acc:' num2str(bestlambda) '/' num2str(bestacc)])
    end
end
std_lambda = bestlambda;
%% Cross validation to select the best lambda for logit + log-dist
disp('Cross validation to select the best lambda for logit + log-dist');
eta = 0.00001;
eps = 1e-3;
max_itr = 10000;
bestlambda = 0;
bestacc = 0;
for itr1 = 1:length(lambda)
    disp(['lambda:' num2str(lambda(itr1))]);
    % train and test
    acc1 = [];
    for itr2 = 1:5
        % prepare data
        XXvalid  = log_Xtrain((Indices==itr2),:);
        yyvalid  = ytrain((Indices==itr2),:);
        
        XXtrain = log_Xtrain((Indices~=itr2),:);
        yytrain = ytrain((Indices~=itr2),:);
        
        w0 = rand(size(Xtrain,2)+1,1);
        [w, loglike] = train_lr(XXtrain,yytrain,w0,eps,lambda(itr1),eta,max_itr);
        % test it
        [ypred,tp,tn,fp,fn] = test_lr(XXvalid,yyvalid,w);
        acc1 = [acc1 (tp+tn)/(tp+fp+fn+tn)];
    end
    acc = mean(acc1);
    
    if (acc>bestacc)
        bestlambda = lambda(itr1);
        bestacc = acc;
        disp(['Best lambda/Acc:' num2str(bestlambda) '/' num2str(bestacc)])
    end
end
log_lambda = bestlambda;
%% Results for different parameters.
% std + naive bayes
disp('std + naive bayes');
[mu, stdev, pr1] = train_gnb(std_Xtrain,ytrain);
[~, tp, tn, fp, fn] = test_gnb(std_Xtest,ytest,mu,stdev,pr1);
disp(['Accuracy:' num2str((tp+tn)/(tp+fp+fn+tn))]);
disp(['tp: ' num2str(tp)]);
disp(['tn: ' num2str(tn)]);
disp(['fp: ' num2str(fp)]);
disp(['fn: ' num2str(fn)]);
%% log + naive bayes
disp('log + naive bayes');
[mu, stdev, pr1] = train_gnb(log_Xtrain,ytrain);
[~, tp, tn, fp, fn] = test_gnb(log_Xtest,ytest,mu,stdev,pr1);
disp(['Accuracy:' num2str((tp+tn)/(tp+fp+fn+tn))]);
disp(['tp: ' num2str(tp)]);
disp(['tn: ' num2str(tn)]);
disp(['fp: ' num2str(fp)]);
disp(['fn: ' num2str(fn)]);
%% std  + logit
disp('std + logit');
w0 = rand(size(Xtrain,2)+1,1);
[w, loglike] = train_lr(std_Xtrain,ytrain,w0,eps,std_lambda,eta,max_itr);
[~,tp,tn,fp,fn] = test_lr(std_Xtest,ytest,w);
acc = (tp+tn)/(tp+fp+fn+tn);
disp(['Accuracy:' num2str(acc)]);
disp(['tp: ' num2str(tp)]);
disp(['tn: ' num2str(tn)]);
disp(['fp: ' num2str(fp)]);
disp(['fn: ' num2str(fn)]);
%% log + logit
disp('log + logit');
w0 = rand(size(Xtrain,2)+1,1);
[w, loglike] = train_lr(log_Xtrain,ytrain,w0,eps,log_lambda,eta,max_itr);
[~,tp,tn,fp,fn] = test_lr(log_Xtest,ytest,w);
acc = (tp+tn)/(tp+fp+fn+tn);
disp(['Accuracy:' num2str(acc)]);
disp(['tp: ' num2str(tp)]);
disp(['tn: ' num2str(tn)]);
disp(['fp: ' num2str(fp)]);
disp(['fn: ' num2str(fn)]);
