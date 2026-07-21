k <- 40  # failures (non-defective units)
r <- 3  # successes (defective units)
p <- 0.1  # probability of success (defective)



# Using dnbinom
prob_r <- dnbinom(k, size = r, prob = p)
pnbinom(44, mu=10, size=3)


print(sprintf("R calculation: %.4f", prob_r))

# Manual calculation for verification
manual_calc <- choose(k + r - 1, k) * p^r * (1-p)^k
print(sprintf("Manual calculation: %.4f", manual_calc))


plot(3:40,sapply(3:40, dnbinom, size=r, prob=p), type='l')




m.df <- metalocus.df

m.df <- m.df[m.df$abbv == 'Bocin',]


require(MASS)
require(ggplot2)

barplot(table(m.df$member_annotations))
ggplot(m.df, aes(member_annotations, fill = sizing)) + geom_histogram(binwidth = 1) + facet_grid(sizing ~ ., margins = TRUE, scales = "free")

# glm.nb(formula = daysabs ~ math + prog, data = dat, init.theta = 1.032713156, 
#            link = log)
glm <- glm.nb(formula = member_annotations ~ sizing, data = m.df, init.theta = 1.032713156, link = log)

summary(glm)


dnbinom(x, size, prob)









# plotting binom classifications ------------------------------------------------------------

## this makes use of two functions which have been moved to functions.R
# get_metalocus_mat()
# binary_p()

ls <- binary_p('Bocin')
ls$plot()

ls <- binary_p('Scpom')
ls$plot()

ls <- binary_p('Cocin')
ls$plot()


ls <- binary_p('Fugra')
ls$plot()

ls <- binary_p('Blgra')
ls$plot()


ls <- binary_p('Pabra')
ls$plot()

ls <- binary_p('Mulus')
ls$plot()


ls <- binary_p('Pyory')
ls$plot()
table(ls$random)


m.df <- metalocus.df

for (abbv in unique(m.df$abbv)) {
  message(abbv)
  ls <- binary_p(abbv)
  ls$plot()
}



# chatgpt example ---------------------------------------------------------

# ---------- helpers ----------

# Estimate f from the lower quantile of genes (robust to true positives)
estimate_f_lower_quantile <- function(binary_matrix, q=0.5) {
  totals <- rowSums(binary_matrix, na.rm=TRUE)
  G <- nrow(binary_matrix)
  cutoff <- max(1, floor(G * q))
  sel_idx <- order(totals)[1:cutoff]
  data <- as.vector(as.matrix(binary_matrix[sel_idx, ]))
  mean(data, na.rm=TRUE)
}

# Compute binomial survival p-values (P[X >= k])
binomial_pvals <- function(binary_matrix, f) {
  totals <- rowSums(binary_matrix, na.rm=TRUE)
  m_i   <- rowSums(!is.na(binary_matrix))
  G <- nrow(binary_matrix)
  pvals <- numeric(G)
  for (i in seq_len(G)) {
    k <- totals[i]
    m <- m_i[i]
    if (k > 0) {
      pvals[i] <- pbinom(k - 1, size=m, prob=f, lower.tail=FALSE)
    } else {
      pvals[i] <- 1.0
    }
  }
  pvals
}

# Per-m thresholds: smallest c with P(X>=c) <= alpha
per_m_thresholds <- function(f, max_m=37, alphas=c(0.05,0.01)) {
  tbl <- list()
  for (m in 1:max_m) {
    entry <- list()
    for (a in alphas) {
      c_val <- NA
      for (k in 0:m) {
        if (pbinom(k-1, size=m, prob=f, lower.tail=FALSE) <= a) {
          c_val <- k
          break
        }
      }
      entry[[as.character(a)]] <- c_val
    }
    tbl[[as.character(m)]] <- entry
  }
  tbl
}

# ---------- example usage ----------

# Suppose binary_matrix is your G x S matrix of 0/1 (genes x samples)
# Example: simulate
set.seed(123)
G <- 10000; S <- 37
# binary_matrix <- matrix(rnbinom(G*S, size=1, mu=1), nrow=G, ncol=S)
binary_matrix <- get_metalocus_mat("Bocin")

barplot(table(rowSums(binary_matrix)))

# Estimate null f
f_hat <- estimate_f_lower_quantile(binary_matrix, q=0.5)
cat("Estimated f:", f_hat, "\n")

# Compute per-gene binomial p-values
pvals <- binomial_pvals(binary_matrix, f_hat)

# Multiple-testing correction (Benjamini-Hochberg FDR)
padj <- p.adjust(pvals, method="BH")

# Find significant genes
sig_genes <- which(padj < 0.05)
length(sig_genes)

# Per-m thresholds (lookup table)
thresholds <- per_m_thresholds(f_hat, max_m=37, alphas=c(0.05,0.01))
thresholds[["37"]]



m.df[which(padj < 0.05), ]



# now glm nbinom ----------------------------------------------------------

# Required packages
if(!require(MASS)) install.packages("MASS")
if(!require(pscl)) install.packages("pscl")   # for zeroinfl (optional)
if(!require(ggplot2)) install.packages("ggplot2")
library(MASS)
library(pscl); 
library(ggplot2)

# ---------- Inputs ----------
# mat: G x S binary (0/1) matrix, rows genes, cols samples
# Example: simulate small example if mat not provided
#set.seed(1)
#G <- 10000; S <- 37
#mat <- matrix(rbinom(G*S, size=1, prob=0.02), nrow=G, ncol=S)

# replace above with your actual matrix
mat <- get_metalocus_mat("Bocin")

# ---------- Precompute totals and m_i ----------
T <- rowSums(mat, na.rm = TRUE)     # totals per gene
m_i <- rowSums(!is.na(mat))         # number of samples observed per gene (usually constant)

df <- data.frame(T = T, m = m_i)

# ---------- 1) Fit NB null via GLM (MASS::glm.nb) ----------
# Model totals T_i ~ NB(mean = m_i * mu0, dispersion = theta)
# Use offset log(m_i) so intercept estimates log(mu0)
fit_nb <- glm.nb(T ~ 1 + offset(log(m)), data = df, link = log)
summary(fit_nb)

# Extract parameters:
log_mu0_hat <- coef(fit_nb)[1]
mu0_hat <- exp(log_mu0_hat)            # per-sample mean under null
theta_hat <- fit_nb$theta               # this is "size" parameter (theta) such that Var = mu + mu^2 / theta

cat(sprintf("Estimated mu0 per sample = %.6f\n", mu0_hat))
cat(sprintf("Estimated theta (size) = %.6f; dispersion phi = 1/theta = %.6f\n", theta_hat, 1/theta_hat))


# ---------- 2) Compute per-gene tail p-values under the fitted null ----------
# R's pnbinom uses parameterization with 'size' such that Var = mu + mu^2/size
mu_i_hat <- mu0_hat * m_i
# p-value P(T >= observed)
pvals_nb <- ifelse(T > 0, pnbinom(T - 1, size = theta_hat, mu = mu_i_hat, lower.tail = FALSE), 1.0)

table(pvals_nb < 0.05)

# Adjust for multiple testing (BH)
padj_nb <- p.adjust(pvals_nb, method = "BH")

# Results summary
table(padj_nb < 0.05)
table_significant <- table(padj_nb < 0.05)
cat("Number significant at FDR 0.05:", sum(padj_nb < 0.05), "\n")

# ---------- 3) Per-m critical thresholds (lookup table) ----------
per_m_thresholds_nb <- function(mu0, theta, max_m = max(m_i), alphas = c(0.05, 0.01)) {
  out <- data.frame(m = 1:max_m)
  for(a in alphas) {
    crits <- sapply(1:max_m, function(m) {
      mu = mu0 * m
      # find smallest c s.t. P(T >= c) <= a
      c_val <- NA
      for(k in 0:m) {
        pval <- pnbinom(k - 1, size = theta, mu = mu, lower.tail = FALSE)
        if(pval <= a) { c_val <- k; break }
      }
      c_val
    })
    out[[paste0("crit_alpha_", a)]] <- crits
  }
  out
}

thresholds <- per_m_thresholds_nb(mu0_hat, theta_hat, max_m = max(m_i), alphas = c(0.05, 0.01))
print(head(thresholds, 10))
print(thresholds[thresholds$m == max(m_i), ])

# ---------- 4) Goodness-of-fit checks ----------
# 4a. Observed vs expected frequency table for totals 0..max_m
obs_tab <- as.integer(table(factor(T, levels = 0:max(m_i))))
exp_probs <- sapply(0:max(m_i), function(k) {
  # average expected probability across genes with possibly varying m; 
  # simpler: compute expected distribution assuming m = modal m (or do weighted)
  # We'll approximate using m = most common m:
  modal_m <- as.numeric(names(which.max(table(m_i))))
  mu_modal <- mu0_hat * modal_m
  dnbinom(k, size = theta_hat, mu = mu_modal)
})
exp_tab <- length(T) * exp_probs

obs_exp_df <- data.frame(count = 0:max(m_i), observed = obs_tab, expected = exp_tab)
# Quick plot
ggplot(obs_exp_df, aes(x = count)) +
  geom_bar(aes(y = observed), stat="identity", alpha=0.6) +
  geom_point(aes(y = expected), color = "red", size = 1.5) +
  geom_line(aes(y = expected), color = "red", linetype = "dashed") +
  labs(title = "Observed (bars) vs expected (red) totals under NB null (modal m used)",
       y = "Number of genes")

# 4b. Pearson chi-square goodness of fit (approx; caveats for small cells)
chi_sq <- sum( (obs_tab - exp_tab)^2 / pmax(exp_tab, 1) )
df_chi <- length(obs_tab) - 1 - 1   # bins - 1 - #estimated params (mu0 and theta)
p_chi <- pchisq(chi_sq, df = df_chi, lower.tail = FALSE)
cat(sprintf("Pearson chi-square = %.2f, df = %d, p = %.3g\n", chi_sq, df_chi, p_chi))

# 4c. Check zero inflation: compare observed zeros vs expected zeros
obs0 <- obs_tab[1]
exp0 <- exp_tab[1]
cat(sprintf("Observed zeros = %d, expected zeros = %.2f\n", obs0, exp0))

# If observed zeros >> expected zeros, consider zero-inflated NB:
if(obs0 > 1.5 * exp0) {
  cat("Consider zero-inflated NB (observed zeros considerably higher than expected).\n")
}

# ---------- 5) Optional: fit zero-inflated NB (pscl::zeroinfl) ----------
# You need a formula with predictors; for null model, we can do: T ~ offset(log(m)) | 1 
# (count model uses NB, zero-inflation model intercept only)
zinb_fit <- try(zeroinfl(T ~ offset(log(m)), data = df, dist = "negbin"), silent = TRUE)
if(!inherits(zinb_fit, "try-error")) {
  print(summary(zinb_fit))
  # Compare AIC
  cat("AIC glm.nb:", AIC(fit_nb), "AIC ZINB:", AIC(zinb_fit), "\n")
}

# ---------- 6) Optional: 2-component NB mixture (EM) on totals ----------
# If you suspect a mixture (background + real), you can fit a naive EM for two NB components.
# This is a more custom step; see below for a simple EM sketch if you want.






