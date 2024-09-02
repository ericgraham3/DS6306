

attributes <- c("Computer Science", "Math", "Statistics", "Machine Learning", "Domain Expertise", "Communication and Presentation Skills", "Data Visualization")

scores <- c(8, 6, 7.5, 5, 8.5, 9, 7.5)

profile <- data.frame(Attributes = attributes, Score = scores)
library(ggplot2)
ggplot(profile, aes(x = Attributes, y = Score, fill = Attributes)) + 
  geom_bar(stat = "identity") + labs(x="Attributes", y = "Score") + 
  scale_x_discrete(limits = (attributes), guide = guide_axis(n.dodge = 2)) + 
  ylim(0, 10) + 
  theme(legend.position="none") + geom_text(aes(label = Score), vjust = 1.5, colour = "black") +
  ggtitle("Eric Graham's Data Science Profile") +
  theme(plot.title = element_text(hjust = 0.5))

