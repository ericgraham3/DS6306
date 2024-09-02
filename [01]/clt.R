population = rchisq(10000000, 2)
hist(population)
summary(population)
mean(population)
sd(population)
# according to central limit theorem, the sample means should have a normal distribution, the mean should be the same as that of the population (2) and the sd should be equal to (populationsd/(sqrt(n=50)))
simulations = 10000
xbar_holder = numeric(simulations)

for (i in 1:simulations)
{
  sample1 = sample(population, 50)
  xbar = mean(sample1)
  xbar_holder[i] = xbar
}


summary(xbar_holder)
hist(xbar_holder)
