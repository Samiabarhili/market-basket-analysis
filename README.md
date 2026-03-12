# Market basket analysis | Association Rule Mining

This project explores **association rule mining** using the Apriori algorithm to discover relationships between items in transactional datasets.

The objective is to identify patterns such as:

milk → cereal  
bread → butter  

These relationships are evaluated using:

- Support
- Confidence
- Lift

## Datasets

Two datasets were used:

- Titanic dataset (passenger characteristics and survival)
- Mushroom dataset (mushroom attributes and edibility)

## Methods

The analysis was performed in **R** using the `arules` package.

Steps:

1. Convert datasets into transactional format
2. Compute frequent itemsets using Apriori
3. Generate association rules
4. Rank rules by confidence and lift
5. Interpret the strongest relationships

## Tools

- R
- arules
- data mining techniques

## Example rule

Sex = female → Survived = yes

This rule indicates that female passengers had a higher probability of survival.

Install R
 ```bash
    sudo apt update
    sudo apt install r-base -y
```
Check if R works (R version 4.x.x)
```bash
    R --version
```
Install the package arules
```bash
R
install.packages("arules")
install.packages("arulesViz")
q()
n
```
Launch the script
```bash
Rscript scripts/titanic_association_rules.R
Rscript scripts/mushroom_association_rules.R
```