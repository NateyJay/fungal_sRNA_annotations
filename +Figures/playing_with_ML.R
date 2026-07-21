# Helper packages
library(dplyr)     # for data manipulation
library(ggplot2)   # for awesome graphics

# Modeling process packages
library(rsample)   # for resampling procedures
library(caret)     # for resampling and model training

library(ranger)  # c++ implementation of RF



## splitting


set.seed(123)  # for reproducibility
index_2 <- createDataPartition(ames$Sale_Price, p = 0.7, 
                               list = FALSE)
ames_train <- ames[index_2, ]
ames_test  <- ames[-index_2, ]




## rf

n_features <- length(setdiff(names(ames_train), "Sale_Price"))

# train a default random forest model
ames_rf1 <- ranger(
  Sale_Price ~ ., 
  data = ames_train,
  mtry = floor(n_features / 3),
  respect.unordered.factors = "order",
  seed = 123
)

# get OOB RMSE
(default_rmse <- sqrt(ames_rf1$prediction.error))

plot


pred = predict(ames_rf1, ames_test)

cbind(ames_test$Sale_Price, pred$predictions)

head(ames_test)
ames_rf1$forest$num.trees
str(ames_rf1)


rg = ranger(Species ~ ., data = iris)
rg$predictions




# predicting context ----------------------------------------------------


m.df <- metalocus.df
m.df$replication <- factor(m.df$replication)

l.df <- locus.df
l.df$context <- m.df$context[match(l.df$metalocus, m.df$metalocus)]
l.df$context <- str_split_fixed(l.df$context, '/',2)[,1]
l.df$context <- factor(l.df$context)

l.df$replication <- m.df$replication[match(l.df$metalocus, m.df$metalocus)]
# l.df$replication <- factor(l.df$replication, levels=c('none','binom','binom+project','binom+sizing','binom+project+sizing'))

passing_abbvs <- dcast(l.df, abbv ~ 'passes', value.var='replication', function(x) any(str_detect(x,'binom')))
passing_abbvs <- passing_abbvs$abbv[passing_abbvs$passes]
l.df$known <- l.df$abbv %in% passing_abbvs


# supports = c(`none`="none",
#              `binom`='binom',
#              `binom+project`='binom',
#              `binom+sizing`='binom',
#              `binom+project+sizing`='binom'
#              )
# l.df$support <- supports[m.df$replication[match(l.df$metalocus, m.df$metalocus)]]
# l.df$support <- factor(l.df$support, c('none','binom'))

l.df$length = l.df$end - l.df$start
l.df$fivep = str_sub(l.df$majorRNA, 1,1)

columns = c('sizecall','depth','length','rpm','rpkm','fracTop','complexity','skew','fivep', 'context')



unknown.df <- l.df[!l.df$known, columns]
l.df       <- l.df[l.df$known,  columns]

set.seed(123)  # for reproducibility
index_1 <- sample(1:nrow(l.df), round(nrow(l.df) * 0.7))
train.df <- l.df[index_1,]
test.df  <- l.df[-index_1,]


rg <- ranger(context ~ ., data= train.df,
             mtry = floor((ncol(l.df)-1) / 3))
pd <- predict(rg, test.df)

# tab = table(test=test.df$replication, prediction=pd$predictions)
# tab
# tab = matrix(tab, nrow=nrow(tab))
# row.names(tab) <- levels(l.df$replication)
# colnames(tab) <- levels(l.df$replication)

tab = table(test=test.df$context, prediction=pd$predictions)
tab
tab = matrix(tab, nrow=nrow(tab))
row.names(tab) <- levels(l.df$context)
colnames(tab) <- levels(l.df$context)

par(mar=c(4,5,5,4))
lp <- layermap(tab, cluster_rows = F,
               palette = 'reds')
lp <- lp_names(lp, 2)
lp <- lp_names(lp, 3)








# predicting rep status ----------------------------------------------------





make_support_matrix <- function(summarize_support=T) {
  m.df <- metalocus.df
  m.df$rep_evidence <- factor(m.df$rep_evidence)
  
  
  rl.df <- raw_locus.df
  
  
  l.df <- locus.df
  
  supports = c(`0-none`="none",
               `1-annotation_pb`='none',
               `2-project_count`='supported',
               `3-project_pb`='supported'
               )
  m <- match(l.df$metalocus, m.df$metalocus)
  l.df$support <- supports[m.df$rep_evidence[m]]
  l.df$support <- factor(l.df$support, c('none','supported'))
  l.df$support[m.df$sizing[m] != 'typical'] <- 'none'
  
  
  
  # if (! summarize_support) {
  #     supports = c(`none`="none",
  #               `binom`='binom',
  #               `binom+project`='binom+project',
  #               `binom+sizing`='binom',
  #               `binom+project+sizing`='binom+project'
  #   )
  #   l.df$support <- supports[m.df$replication[match(l.df$metalocus, m.df$metalocus)]]
  #   l.df$support <- factor(l.df$support, c('none','binom', 'binom+project'))
  #   
  # } else {
  #   supports = c(`none`="none",
  #                `binom`='binom',
  #                `binom+project`='binom',
  #                `binom+sizing`='binom',
  #                `binom+project+sizing`='binom'
  #                )
  #   l.df$support <- supports[m.df$replication[match(l.df$metalocus, m.df$metalocus)]]
  #   l.df$support <- factor(l.df$support, c('none','binom'))
  # }
  
  # l.df$width = l.df$end - l.df$start
  l.df$fivep = str_sub(l.df$majorRNA, 1,1)
  
  m <- match(l.df$ID, paste0(rl.df$Name, '-', rl.df$project, '-', rl.df$annotation))
  l.df$Gap <- rl.df$Gap[m]
  l.df$MajorRNAReads <- rl.df$MajorRNAReads[m]
  l.df$size_2n_depth <- rl.df$size_2n_depth[m]
  l.df$Length <- rl.df$Length[m]
  
  sc_lev = c("N")
  for (i in 16:28) {
    sc_lev = c(sc_lev, as.character(i), 
               paste(i:(i+1), collapse="_"),
               paste((i-1):(i+1), collapse="_"))
  }
  
  l.df$sizecall <- factor(l.df$sizecall, levels=sc_lev)
  
  l.df$size_2n_depth[l.df$sizecall == 'N'] <- 0
  
  row.names(l.df) <- l.df$ID
  
  # size.df <- data.frame()
  # for (p in unique(l.df$project)) {
  #   message(p)
  #   for (a in unique(l.df$annotation[l.df$project == p])) {
  #     count_file = str_glue("{dirs$ann}/{p}/counts/tradeoff_{a}_deepcounts.txt")
  #     if (!file.exists(count_file)) next
  #     
  #     df <- read.delim(count_file)
  #     df <- df[df$strand != "*" & df$condition == a,]
  #     
  #     df <- rbind(df, data.frame(name='none',condition=a,rg='none',length=rep(15:30,each=2),strand=rep(c("-","+"), 2),count=0))
  #     
  #     if (nrow(df) == 0) next
  #     df <- dcast(df, name ~ length + strand, value.var='count', fun.aggregate=sum)
  #     names(df) <- str_replace(names(df), "_", "")
  #     
  #     df$ID <- str_glue("{df$name}-{p}-{a}")
  #     size.df <- rbind(size.df, df)
  #     
  #   }
  #   
  #   size.df$name <- NULL
  #   
  #   size.df <- size.df[rowSums(size.df) > 0,]
  #   
  #   s.df <- size.df
  #   s.df <- melt(s.df, id.vars = "ID")
  #   s.df$strand <- str_sub(s.df$variable, 3,3)
  #   s.df$size <- str_sub(s.df$variable, 1,2)
  #   s.df$variable <- NULL
  #   
  #   t.df <- s.df
  #   t.df <- dcast(t.df, ID + size ~ strand, value.var='value', fun.aggregate=sum)
  #   t.df$best_strand <- ifelse(t.df$`-` > t.df$`+`, "-", "+")
  #   
  #   s.df$best_strand <- t.df$best_strand[match(s.df$ID, t.df$ID)]
  #   s.df$stranding <- ifelse(s.df$strand == s.df$best_strand, "ss", "as")
  #   
  #   s.df <- dcast(s.df, ID ~ size + stranding, value.var='value', fun.aggregate=sum)
  #   
  #   size.df <- s.df
  #   
  #   rownames(size.df) <- size.df$ID
  #   size.df$ID <- NULL
  #   
  #   prop.df <- size.df / rowSums(size.df)  
  #   
  # 
  #   
  #       
  #   
  #   
  # }
  # 
  # 
  # 
  # 
  
  
  columns = c(#"metalocus","ID","type","seqid","start","end","strand","project","annotation",
    "sizecall","depth","rpm",#"rpkm",
    "fracTop",    
    "complexity","skew",#"majorRNA","abbv",
    "support","fivep","Gap","MajorRNAReads","size_2n_depth","Length")
  
  # return(list(metadata=l.df[,columns], sizes=size.df, prop=prop.df))
  return(l.df[,columns])
}

supports = make_support_matrix()
l.df <- supports$metadata

set.seed(123)  # for reproducibility
index_1 <- sample(1:nrow(l.df), round(nrow(l.df) * 0.7))
train.df <- l.df[index_1,]
test.df  <- l.df[-index_1,]


rg <- ranger(support ~ ., data= train.df,
             mtry = floor(ncol(l.df)-1) / 3)
             # mtry = floor(sqrt(ncol(l.df))))
pd <- predict(rg, test.df)

# tab = table(test=test.df$replication, prediction=pd$predictions)
# tab
# tab = matrix(tab, nrow=nrow(tab))
# row.names(tab) <- levels(l.df$replication)
# colnames(tab) <- levels(l.df$replication)

tab = table(test=test.df$support, prediction=pd$predictions)
tab
tab = matrix(tab, nrow=nrow(tab))
row.names(tab) <- levels(l.df$support)
colnames(tab) <- levels(l.df$support)

par(mar=c(4,5,5,4))
lp <- layermap(tab, cluster_rows = F,
               palette = 'reds')
lp <- lp_names(lp, 2)
lp <- lp_names(lp, 3)



lp_plot_values(lp)


# rep status, non categorical ---------------------------------------------



m.df <- metalocus.df
m.df$replication <- factor(m.df$replication)


l.df <- locus.df
# l.df <- replication(m.df$replication[match(l.df$metalocus, m.df$metalocus)])
# l.df$replication <- factor(l.df$replication, levels=c('none','binom','binom+project','binom+sizing','binom+project+sizing'))
supports = c(`none`="none",
             `binom`='binom',
             `binom+project`='binom',
             `binom+sizing`='binom',
             `binom+project+sizing`='binom'
)
l.df$support <- supports[m.df$replication[match(l.df$metalocus, m.df$metalocus)]]
l.df$support <- factor(l.df$support, c('none','binom'))

l.df$width = l.df$end - l.df$start
l.df$fivep = str_sub(l.df$majorRNA, 1,1)
l.df <- l.df[, setdiff(names(l.df),c('seqid','start','end', 'ID', 'metalocus','project','annotation','abbv', 'type', 'majorRNA', 'replication'))]


set.seed(123)  # for reproducibility
index_1 <- sample(1:nrow(l.df), round(nrow(l.df) * 0.7))
train.df <- l.df[index_1,]
test.df  <- l.df[-index_1,]


rg <- ranger(support ~ ., data= train.df,
             mtry = floor((ncol(l.df)-1) / 3))
pd <- predict(rg, test.df)

# tab = table(test=test.df$replication, prediction=pd$predictions)
# tab
# tab = matrix(tab, nrow=nrow(tab))
# row.names(tab) <- levels(l.df$replication)
# colnames(tab) <- levels(l.df$replication)

tab = table(test=test.df$support, prediction=pd$predictions)
tab
tab = matrix(tab, nrow=nrow(tab))
row.names(tab) <- levels(l.df$support)
colnames(tab) <- levels(l.df$support)

par(mar=c(4,5,5,4))
lp <- layermap(tab, cluster_rows = F,
               palette = 'reds')
lp <- lp_names(lp, 2)
lp <- lp_names(lp, 3)



lp_plot_values(lp)



library(ROCR)




pred <- prediction(as.numeric(as.vector(pd$predictions)=='binom'), as.numeric(as.vector(test.df$support)=='binom'))
perf <- performance(pred, "tpr", "fpr")
plot(perf,main="ROC Curve") 


pred <- prediction(prediction_for_roc_curve[,i],true_values)
perf <- performance(pred, "tpr", "fpr")
if (i==1)
{
  plot(perf,main="ROC Curve",col=pretty_colours[i]) 
}
else
{
  plot(perf,main="ROC Curve",col=pretty_colours[i],add=TRUE) 
}
# Calculate the AUC and print it to screen
auc.perf <- performance(pred, measure = "auc")
}






# boosted tree -----------------------------------------------------------------

library(xgboost)
library(caTools)

## example

set.seed(42)
sample_split <- sample.split(Y = iris$Species, SplitRatio = 0.7)
train_set <- subset(x = iris, sample_split == TRUE)
test_set <- subset(x = iris, sample_split == FALSE)

y_train <- as.integer(train_set$Species) - 1
y_test <- as.integer(test_set$Species) - 1
X_train <- train_set %>% select(-Species)
X_test <- test_set %>% select(-Species)

xgb_train <- xgb.DMatrix(data = as.matrix(X_train), label = y_train)
xgb_test <- xgb.DMatrix(data = as.matrix(X_test), label = y_test)
xgb_params <- list(
  booster = "gbtree",
  eta = 0.01,
  max_depth = 8,
  gamma = 4,
  subsample = 0.75,
  colsample_bytree = 1,
  objective = "multi:softprob",
  eval_metric = "mlogloss",
  num_class = length(levels(iris$Species))
)
xgb_model <- xgb.train(
  params = xgb_params,
  data = xgb_train,
  nrounds = 5000,
  verbose = 1
)
xgb_model






l.df <- make_support_matrix()

l.df <- l.df[,setdiff(names(l.df), c('sizecall','fivep'))]


set.seed(123)  # for reproducibility
index_1 <- sample(1:nrow(l.df), round(nrow(l.df) * 0.7))
train.df <- l.df[index_1, ]
test.df  <- l.df[-index_1, ]
columns = setdiff(names(train.df), "support")

xgb_train <- xgb.DMatrix(data = as.matrix(train.df[, columns]),
                         label = as.integer(train.df$support)-1)
xgb_test <- xgb.DMatrix(data = as.matrix(test.df[, columns]), 
                        label = as.integer(l.df$support[-index_1])-1)


xgb_params <- list(
  booster = "gbtree",
  eta = 0.01,
  max_depth = 8,
  gamma = 4,
  subsample = 0.75,
  colsample_bytree = 1,
  objective = "multi:softprob",
  eval_metric = "mlogloss",
  num_class = length(levels(l.df$support))
)

xgb_model <- xgb.train(
  params = xgb_params,
  data = xgb_train,
  nrounds = 5000,
  verbose = 1
)
xgb_model


pd <- predict(xgb_model, as.matrix(test.df[, columns]))
pd <- as.data.frame(pd)
colnames(pd) <- levels(l.df$support)
pd$ground <- test.df$support
pd$prediction <- ifelse(pd$binom > 0.5, 'binom', 'none')


table(test=pd$ground, pred=pd$prediction)





# xgboost again -----------------------------------------------------------

library(h2o)
library(recipes)
library(xgboost)
set.seed(123)

train_h2o <- as.h2o(ames_train)
ames <- AmesHousing::make_ames()


split <- rsample::initial_split(ames, prop = 0.7, 
                       strata = "Sale_Price")
ames_train  <- rsample::training(split)
ames_test   <- rsample::testing(split)



h2o.init(max_mem_size = "10g")

train_h2o <- as.h2o(ames_train)
response <- "Sale_Price"
predictors <- setdiff(colnames(ames_train), response)


xgb_prep <- recipe(Sale_Price ~ ., data = ames_train) %>%
  step_integer(all_nominal()) %>%
  prep(training = ames_train, retain = TRUE) %>%
  juice()



dtrain = xgb.DMatrix(xgb_prep[setdiff(names(xgb_prep), "Sale_Price")], label = xgb_prep$Sale_Price, nthread = 2)


ames_xgb <- xgb.cv(
  data = dtrain,
  nrounds = 6000,
  
  early_stopping_rounds = 50, 
  nfold = 10,
  params = list(
    objective = "reg:linear",
    eta = 0.1,
    max_depth = 3,
    min_child_weight = 3,
    subsample = 0.8,
    colsample_bytree = 1.0),
  verbose = 0
)  

# minimum test CV RMSE
min(ames_xgb$evaluation_log$test_rmse_mean)

hyper_grid <- expand.grid(
  eta = 0.01,
  max_depth = 3, 
  min_child_weight = 3,
  subsample = 0.5, 
  colsample_bytree = 0.5,
  gamma = c(0, 1, 10, 100, 1000),
  lambda = c(0, 1e-2, 0.1, 1, 100, 1000, 10000),
  alpha = c(0, 1e-2, 0.1, 1, 100, 1000, 10000),
  rmse = 0,          # a place to dump RMSE results
  trees = 0          # a place to dump required number of trees
)

# grid search
for(i in seq_len(nrow(hyper_grid))) {
  set.seed(123)
  message(i)
  m <- xgb.cv(
    data = dtrain,
    nrounds = 4000,
   
    early_stopping_rounds = 50, 
    nfold = 10,
    verbose = 0,
    params = list( 
      objective = "reg:linear",
      eta = hyper_grid$eta[i], 
      max_depth = hyper_grid$max_depth[i],
      min_child_weight = hyper_grid$min_child_weight[i],
      subsample = hyper_grid$subsample[i],
      colsample_bytree = hyper_grid$colsample_bytree[i],
      gamma = hyper_grid$gamma[i], 
      lambda = hyper_grid$lambda[i], 
      alpha = hyper_grid$alpha[i]
    ) 
  )
  hyper_grid$rmse[i] <- min(m$evaluation_log$test_rmse_mean)
  hyper_grid$trees[i] <- m$early_stop$best_iteration
}

hyper_grid %>%
  filter(rmse > 0) %>%
  arrange(rmse) %>%
  glimpse()



params <- list(
  objective = "reg:linear",
  eta = 0.01,
  max_depth = 3,
  min_child_weight = 3,
  subsample = 0.5,
  colsample_bytree = 0.5
)

# train final model
fit <- xgb.train(
  data = dtrain,
  nrounds = 3944,
  params=params
  # verbose = 0
)



# inspecting
xgb.importance(fit)

ptest <- recipe(Sale_Price ~ ., data = ames_test) %>%
  step_integer(all_nominal()) %>%
  prep(training = ames_test, retain = TRUE) %>%
  juice()

dtest = xgb.DMatrix(ptest[setdiff(names(ptest), "Sale_Price")], label = ptest$Sale_Price, nthread = 2)


pred <- predict(fit, dtest)
str(pred)

plot(pred,ptest$Sale_Price)#, xlim=c(450000, 650000), ylim=c(450000, 650000))


# example from xgb help (work) -------------------------------------------------------

data(agaricus.train, package = "xgboost")
data(agaricus.test, package = "xgboost")

## Keep the number of threads to 2 for examples
nthread <- 2
data.table::setDTthreads(nthread)

train <- agaricus.train
test <- agaricus.test

bst <- xgb.train(
  data = xgb.DMatrix(train$data, label = train$label, nthread = 1),
  nrounds = 5,
  params = xgb.params(
    max_depth = 2,
    nthread = nthread,
    objective = "binary:logistic"
  )
)

# use all trees by default
pred <- predict(bst, test$data)
# use only the 1st tree
pred1 <- predict(bst, test$data, iterationrange = c(1, 1))

# Predicting tree leafs:
# the result is an nsamples X ntrees matrix
pred_leaf <- predict(bst, test$data, predleaf = TRUE)
str(pred_leaf)

# Predicting feature contributions to predictions:
# the result is an nsamples X (nfeatures + 1) matrix
pred_contr <- predict(bst, test$data, predcontrib = TRUE)
str(pred_contr)
# verify that contributions' sums are equal to log-odds of predictions (up to float precision):
summary(rowSums(pred_contr) - qlogis(pred))
# for the 1st record, let's inspect its features that had non-zero contribution to prediction:
contr1 <- pred_contr[1,]
contr1 <- contr1[-length(contr1)]    # drop intercept
contr1 <- contr1[contr1 != 0]        # drop non-contributing features
contr1 <- contr1[order(abs(contr1))] # order by contribution magnitude
old_mar <- par("mar")
par(mar = old_mar + c(0,7,0,0))
barplot(contr1, horiz = TRUE, las = 2, xlab = "contribution to prediction in log-odds")
par(mar = old_mar)


# iris

lb <- as.numeric(iris$Species) - 1
num_class <- 3

set.seed(11)

bst <- xgb.train(
  data = xgb.DMatrix(as.matrix(iris[, -5], nthread = 1), label = lb),
  nrounds = 10,
  params = xgb.params(
    max_depth = 4,
    nthread = 2,
    subsample = 0.5,
    objective = "multi:softprob",
    num_class = num_class
  )
)

# predict for softmax returns num_class probability numbers per case:
pred <- predict(bst, as.matrix(iris[, -5]))
str(pred)
# convert the probabilities to softmax labels
pred_labels <- max.col(pred) - 1
# the following should result in the same error as seen in the last iteration
sum(pred_labels != lb) / length(lb)

# compare with predictions from softmax:
set.seed(11)

bst <- xgb.train(
  data = xgb.DMatrix(as.matrix(iris[, -5], nthread = 1), label = lb),
  nrounds = 10,
  params = xgb.params(
    max_depth = 4,
    nthread = 2,
    subsample = 0.5,
    objective = "multi:softmax",
    num_class = num_class
  )
)


pred <- predict(bst, as.matrix(iris[, -5]))
str(pred)
all.equal(pred, pred_labels)
# prediction from using only 5 iterations should result
# in the same error as seen in iteration 5:
pred5 <- predict(bst, as.matrix(iris[, -5]), iterationrange = c(1, 5))
sum(pred5 != lb) / length(lb)

table(test=iris$Species, pred=levels(iris$Species)[pred+1])



# trying again from help (works) ------------------------------------------------------------


library(recipes)
library(xgboost)
library(rsample)
set.seed(123)


l.df <- make_support_matrix()
# l.df <- l.df[str_detect(row.names(l.df), "Bocin"),]

split   <- initial_split(l.df, prop = 0.7, strata = "support")
ltrain  <- training(split)
ltest   <- testing(split)



ptrain <- recipe(support ~ ., data = ltrain) %>%
  step_integer(all_nominal()) %>%
  prep(training = ltrain, retain = TRUE) %>%
  juice()

ptest <- recipe(support ~ ., data = ltest) %>%
  step_integer(all_nominal()) %>%
  prep(training = ltest, retain = TRUE) %>%
  juice()


dtrain = xgb.DMatrix(ptrain[setdiff(names(ptrain), "support")], label = as.numeric(ptrain$support) - 1, nthread = 2)
dtest  = xgb.DMatrix(ptest[setdiff(names(ptest), "support")],   label = as.numeric(ptest$support) - 1,  nthread = 2)




set.seed(11)

bst <- xgb.train(
  data = dtrain,
  nrounds = 100,
  params = xgb.params(
    # booster = "gbtree",
    # eta = 0.01,
    # max_depth = 6,
    nthread = 2,
    subsample = 0.5,
    objective = "multi:softprob",
    num_class = length(levels(l.df$support))
  )
)

xgb.importance(bst)


pred <- predict(bst, dtest)
str(pred)
# pred

table(test=ptest$support, pred=max.col(pred))


# using size data ---------------------------------------------------------

size.df <- supports$sizes
l.df <- supports$metadata

m = match(row.names(l.df), row.names(size.df))

s.df <- size.df[m[!is.na(m)],]
support <- l.df$support[match(rownames(s.df), rownames(l.df))]


split   <- initial_split(cbind(s.df, support=support), prop = 0.7, strata = "support")
ltrain  <- training(split)
ltest   <- testing(split)


dtrain = xgb.DMatrix(ltrain[setdiff(names(ltrain), "support")], label = as.numeric(ltrain$support) - 1, nthread = 2)
dtest  = xgb.DMatrix(ltest[setdiff(names(ltest), "support")],   label = as.numeric(ltest$support) - 1,  nthread = 2)



set.seed(11)

bst <- xgb.train(
  data = dtrain,
  nrounds = 100,
  params = xgb.params(
    # booster = "gbtree",
    # eta = 0.01,
    # max_depth = 6,
    nthread = 2,
    subsample = 0.5,
    objective = "multi:softprob",
    num_class = length(levels(l.df$support))
  )
)

xgb.importance(bst)

pred <- predict(bst, dtest)
str(pred)
# pred

table(test=ltest$support, pred=max.col(pred))












# only one l per m --------------------------------------------------------






make_support_matrix <- function(summarize_support=T) {
  m.df <- metalocus.df
  m.df$rep_evidence <- factor(m.df$rep_evidence)
  
  
  
  l.df <- locus.df
  m <- match(l.df$metalocus, m.df$metalocus)
  
  l.df$rep_evidence <- m.df$rep_evidence[m]
  l.df$rep_score    <- m.df$rep_score[m]
  
  table(l.df$rep_evidence, l.df$rep_score)
  
  supports = c(`0-none`="none",
               `1-annotation_pb`='none',
               `2-project_count`='supported',
               `3-project_pb`='supported'
  )
  l.df$support <- supports[m.df$rep_evidence[m]]
  l.df$support <- supports[l.df$rep_evidence]
  
  
  l.df$support <- factor(l.df$support, c('none','supported'))
  # l.df$support[m.df$sizing[m] != 'typical'] <- 'none'
  l.df$score <- m.df$rep_score[m]
  
  table(l.df$score, l.df$support)
  
  # set.seed(42)
  # l.df <- l.df[sample(nrow(l.df)),]
  # l.df <- l.df[!duplicated(l.df$metalocus),]
  
  
  l.df$fivep = str_sub(l.df$majorRNA, 1,1)
  
  m <- match(l.df$ID, paste0(rl.df$Name, '-', rl.df$project, '-', rl.df$annotation))
  l.df$Gap <- rl.df$Gap[m]
  l.df$MajorRNAReads <- rl.df$MajorRNAReads[m]
  l.df$size_2n_depth <- rl.df$size_2n_depth[m]
  l.df$Length <- rl.df$Length[m]
  
  sc_lev = c("N")
  for (i in 16:28) {
    sc_lev = c(sc_lev, as.character(i),
               paste(i:(i+1), collapse="_"),
               paste((i-1):(i+1), collapse="_"))
  }
  
  l.df$sizecall <- factor(l.df$sizecall, levels=sc_lev)
  
  l.df$size_2n_depth[l.df$sizecall == 'N'] <- 0
  
  row.names(l.df) <- l.df$ID
  
  ## removing species with no high-quality metaloci
  dc <- dcast(l.df, abbv ~ support, fun.aggregate = length)
  dc <- dc[dc$supported == 0,]
  l.df <- l.df[!l.df$abbv %in% dc$abbv,]
  
  
  
  columns = c(#"metalocus","ID","type","seqid","start","end","strand","project","annotation",
    'support',
    # 'score',
    "sizecall","depth","rpm",
    "fracTop",    
    "complexity","skew",
    "fivep","Gap",
    "MajorRNAReads","size_2n_depth","Length")
  
  # return(list(metadata=l.df[,columns], sizes=size.df, prop=prop.df))
  return(l.df[,columns])
}


grid_search <- function() {
  
  l.df <- make_support_matrix()
  
  
  prepped <- recipe(support ~ ., data = l.df) %>%
    step_integer(all_nominal()) %>%
    prep(training = l.df, retain = TRUE) %>%
    juice()
  
  dmat = xgb.DMatrix(prepped[setdiff(names(prepped), "support")], label = as.numeric(prepped$support) - 1, nthread = 8)
    
  # bst <- xgb.train(
  #   data = dtrain,
  #   nrounds = 100,
  #   params = xgb.params(
  #     # booster = "gbtree",
  #     # eta = 0.01,
  #     # max_depth = 6,
  #     nthread = 2,
  #     subsample = 0.5,
  #     objective = "multi:softprob",
  #     num_class = length(levels(l.df$support))
  #   )
  
  cv <- xgb.cv(
    data = dmat,
    nrounds = 6000,
    early_stopping_rounds = 50, 
    nfold = 10,
    params = list(
      objective = "multi:softprob",
      num_class = length(levels(l.df$support)),
      # eta = 0.1,
      max_depth = 3,
      min_child_weight = 3,
      subsample = 0.8,
      colsample_bytree = 1.0
      ),
    verbose = 1
  )  
  
  # minimum test CV RMSE
  min(cv$evaluation_log$test_rmse_mean)
  
  hyper_grid <- expand.grid(
    eta = 0.01,
    max_depth = 3, 
    min_child_weight = 3,
    subsample = 0.5, 
    colsample_bytree = 0.5,
    gamma = c(0, 1, 10, 100, 1000),
    lambda = c(0, 1e-2, 0.1, 1, 100, 1000, 10000),
    alpha = c(0, 1e-2, 0.1, 1, 100, 1000, 10000),
    metric = 0,          # a place to dump RMSE results
    trees = 0          # a place to dump required number of trees
  )
  
  # grid search
  for(i in seq_len(nrow(hyper_grid))) {
    set.seed(123)
    message(i)
    
    if (hyper_grid$metric[i] != 0) next
    
    cv <- xgb.cv(
      data = dmat,
      nrounds = 100,
      early_stopping_rounds = 50, 
      nfold = 10,
      params = list(
        objective = "multi:softprob",
        num_class = length(levels(l.df$support)),
        eta = hyper_grid$eta[i],
        max_depth = hyper_grid$max_depth[i],
        min_child_weight = hyper_grid$min_child_weight[i],
        subsample = hyper_grid$subsample[i],
        colsample_bytree = hyper_grid$colsample_bytree[i],
        gamma = hyper_grid$gamma[i],
        lambda = hyper_grid$lambda[i],
        alpha = hyper_grid$alpha[i]
      ),
      verbose = 0
    )  
    hyper_grid$metric[i] <- min(cv$evaluation_log$test_mlogloss_mean)
    hyper_grid$trees[i] <- cv$early_stop$best_iteration
  }
}


test_xbg <- function() {
  
  library(recipes)
  library(xgboost)
  library(rsample)
  set.seed(123)
  
  
  l.df <- make_support_matrix()
  
  split   <- initial_split(l.df, prop = 0.7, strata = "support")
  ltrain  <- training(split)
  ltest   <- testing(split)
  
  
  
  ptrain <- recipe(support ~ ., data = ltrain) %>%
    step_integer(all_nominal()) %>%
    prep(training = ltrain, retain = TRUE) %>%
    juice()
  
  ptest <- recipe(support ~ ., data = ltest) %>%
    step_integer(all_nominal()) %>%
    prep(training = ltest, retain = TRUE) %>%
    juice()
  
  
  dtrain = xgb.DMatrix(ptrain[setdiff(names(ptrain), "support")], label = as.numeric(ptrain$support) - 1, nthread = 2)
  dtest  = xgb.DMatrix(ptest[setdiff(names(ptest), "support")],   label = as.numeric(ptest$support) - 1,  nthread = 2)
  
  
  
  bst <- xgb.train(
    data = dtrain,
    nrounds = 100,
    params = xgb.params(
      # booster = "gbtree",
      # eta = 0.01,
      # max_depth = 6,
      nthread = 2,
      subsample = 0.5,
      objective = "multi:softprob",
      num_class = length(levels(l.df$support))
    )
  )
  # bst <- xgb.train(
  #   data = dtrain,
  #   nrounds = 100,
  #   params = xgb.params(
  #     # booster = "gbtree",
  #     # eta = 0.01,
  #     # max_depth = 6,
  #     nthread = 2,
  #     subsample = 0.5,
  #     objective = "reg:squarederror")
  #   )
  
  xgb.importance(bst)
  
  
  pred <- predict(bst, dtest)
  str(pred)
  # pred
  
  table(test=ptest$support, pred=max.col(pred))
  
  # plot(ptest$support, pred)
  # 
  # pred <- predict(bst, dtrain)
}
test_xbg()


# RF with new supports ----------------------------------------------------




library(ranger)
l.df = make_support_matrix()
set.seed(123)  # for reproducibility

split   <- initial_split(l.df, prop = 0.7, strata = "support")
ltrain  <- training(split)
ltest   <- testing(split)

rg <- ranger(support ~ ., data= ltrain,
             mtry = floor(ncol(l.df)-1) / 3)

# mtry = floor(sqrt(ncol(l.df))))

for (data in list(ltrain, ltest)) {

  pd <- predict(rg, data)
  pd
  tab = table(test=data$support, prediction=pd$predictions)
  tab
}
