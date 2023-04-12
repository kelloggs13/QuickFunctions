---
title: "PieChart.R"
author: "Tobias Byland"
date: "2023-04-12"
output: html_document
---

```{r, include=FALSE}
require(tidyverse)
require(gridExtra)
```

### What is this?

A function to create pie charts with ggplot2.

Takes as input a data.frame with two variables:

-   grp: Names for the groups in the pie chart.

-   value: Values used for the sections in the pie chart - must be absolute values, not percentages.

### Source the function

```{r echo=TRUE, message=FALSE, warning=FALSE}
library(devtools)
SourceURL <- "https://raw.githubusercontent.com/kelloggs13/QuickFunctions/main/PieChart.R"
source_url(SourceURL)
```

### Default call

```{r echo=TRUE, message=FALSE, warning=FALSE}
df.pie <- data.frame(grp=LETTERS[1:5], value = (1:5)*100) 
df.pie %>% mutate(perc = value / sum(value))

PieChart(df.pie, grp, value)
```

### Options

Labels can be placed on the inside:

```{r echo=TRUE, message=FALSE, warning=FALSE}
PieChart(df.pie, grp, value, "inside")
```

Various kind of labels can be used:

```{r eval=FALSE, message=FALSE, warning=FALSE, include=TRUE}
PieChart(df.pie, grp, value, label.type = "perc_abs")
PieChart(df.pie, grp, value, label.type = "abs")
PieChart(df.pie, grp, value, label.type = "perc")
PieChart(df.pie, grp, value, label.type = "grp")
```

```{r echo=FALSE, message=FALSE, warning=FALSE}
p1 <- PieChart(df.pie, grp, value, label.type = "perc_abs") + ggtitle("label.type = 'perc_abs'")
p2 <- PieChart(df.pie, grp, value, label.type = "abs") + ggtitle("label.type = 'abs'")
p3 <- PieChart(df.pie, grp, value, label.type = "perc") + ggtitle("label.type = 'perc'")
p4 <- PieChart(df.pie, grp, value, label.type = "grp") + ggtitle("label.type = 'grp'")
grid.arrange(p1, p2, p3, p4, ncol=2)
```

### Enhance with ggplot2

Since the function returns a ggplot2-object it can easily be modified further:

```{r echo=TRUE, message=FALSE, warning=FALSE}
PieChart(df.pie, grp, value) + 
  theme_dark() +  
  scale_fill_brewer("Set1") + 
  theme(legend.position = "left") + 
  ggtitle("This is a pie chart")
```
