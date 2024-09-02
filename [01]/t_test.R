# Step 1: identify H0 and Ha
# H0: mean age = 21
# Ha: mean age != 21
sample = c(25, 19, 37, 29, 40, 28, 31)
summary(sample)
# step 2: critical value
significance_level = 0.05/2
degrees_of_freedom = length(sample) - 2
qt(p = significance_level, df = degrees_of_freedom)

# step 3, 4 and 5: t-value, p-value, reject or fail to reject H0
t.test(sample, alternative = c("two.sided"), mu = 21, conf.level = 0.95)

# step 6: conclusion