# Titanic Association Rules Analysis
# Author: Samia Barhili

library(arules)

# Load dataset
dataset <- read.table("data/Titanic.csv", sep = ";", header = TRUE)

# Convert dataset to transactions format
titanic_transactions <- as(dataset, "transactions")

# Dataset summary
summary(titanic_transactions)

# Item frequencies
item_frequencies <- itemFrequency(titanic_transactions)
print(item_frequencies)

# Plot items with support greater than 0.2
itemFrequencyPlot(
  titanic_transactions,
  support = 0.2,
  col = "red",
  main = "Items with Support > 0.2"
)

# Plot top 5 most frequent items
itemFrequencyPlot(
  titanic_transactions,
  topN = 5,
  col = "pink",
  main = "Top 5 Most Frequent Items"
)

# Generate association rules
rules <- apriori(
  titanic_transactions,
  parameter = list(support = 0.1, confidence = 0.5)
)

# Rules summary
summary(rules)

# Inspect all rules
inspect(rules)

# Inspect top rules sorted by confidence
rules_by_confidence <- sort(rules, by = "confidence", decreasing = TRUE)
inspect(rules_by_confidence)

# Inspect top rules sorted by lift
rules_by_lift <- sort(rules, by = "lift", decreasing = TRUE)
inspect(rules_by_lift)

# Rules with "Survived=yes" as consequent
survival_rules <- subset(rules, subset = rhs %pin% "Survived=yes")
inspect(survival_rules)

# Rules with "Survived=yes" as consequent and lift > 1
strong_survival_rules <- subset(rules, subset = rhs %pin% "Survived=yes" & lift > 1)
inspect(strong_survival_rules)

# Export top rules by lift
top_rules_lift <- as(sort(rules, by = "lift", decreasing = TRUE), "data.frame")
write.csv(top_rules_lift, "results/titanic_top_rules_by_lift.csv", row.names = FALSE)

# Export top rules related to survival
survival_rules_df <- as(survival_rules, "data.frame")
write.csv(survival_rules_df, "results/titanic_survival_rules.csv", row.names = FALSE)

# Item frequency plot
png("results/titanic_item_frequency.png", width = 800, height = 600)
itemFrequencyPlot(
  titanic_transactions,
  topN = 10,
  col = "steelblue",
  main = "Top 10 Most Frequent Items"
)
dev.off()

library(arulesViz)

png("results/titanic_rules_scatter.png", width = 800, height = 600)
plot(
  rules,
  method = "scatterplot",
  measure = c("support", "confidence"),
  shading = "lift"
)
dev.off()