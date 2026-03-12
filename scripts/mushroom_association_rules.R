# Mushroom Association Rules Analysis
# Author: Samia Barhili

library(arules)

# Load dataset
data("Mushroom")

# Dataset summary
summary(Mushroom)

# Plot items with support greater than 0.2
itemFrequencyPlot(
  Mushroom,
  support = 0.2,
  main = "Items with Support > 0.2"
)

# Plot top 20 most frequent items
itemFrequencyPlot(
  Mushroom,
  topN = 20,
  col = "pink",
  main = "Top 20 Most Frequent Items"
)

# Generate association rules
rules <- apriori(
  Mushroom,
  parameter = list(support = 0.5, confidence = 0.75)
)

# Rules summary
summary(rules)

# Inspect first 10 rules
inspect(rules[1:10])

# Sort rules by lift
rules_by_lift <- sort(rules, by = "lift", decreasing = TRUE)
inspect(rules_by_lift)

# Sort rules by confidence
rules_by_confidence <- sort(rules, by = "confidence", decreasing = TRUE)
inspect(rules_by_confidence)

# Rules with poisonous mushrooms as consequent
poisonous_rules <- subset(rules, subset = rhs %pin% "Class=poisonous")
inspect(poisonous_rules)

# Export top rules by confidence
top_rules_confidence <- as(sort(rules, by = "confidence", decreasing = TRUE), "data.frame")
write.csv(top_rules_confidence, "results/mushroom_top_rules_by_confidence.csv", row.names = FALSE)