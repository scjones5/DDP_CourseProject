---
title: "Esophageal Cancer Prediction Application"
author: "Scott Jones"
framework: io2012
highligher: highlight.js
hitheme: tomorrow
widgets: []
mode: selfcontained
date: '2018-02-01'
output: slidy_presentation
---



## Introduction

- Application issues a prediction probability on likelihood of contracting esophageal cancer.
- There are three contributing factors: age, alcohol consumption and tobacco consumption. 
- We use a generalized linear binomial model to generate a prediction of either disease or no disease. 

---

## GLM Model Code


```r
model <- glm(cbind(ncases, ncontrols) ~ agegp + tobgp * alcgp, 
               data=esoph, family = binomial())
```

---

## Results

- The results vary between a minimum 0.17% chance of cancer for the youngest study participants with little to no alcohol and tobacco consumption to a 62% chance for some of the oldest, most indulgent participants:

```r
predict(model, newdata=data.frame(agegp=factor(5, 
              levels=levels(esoph$agegp)), alcgp=factor(4, 
              levels=levels(esoph$alcgp)), tobgp=factor(3, 
              levels=levels(esoph$tobgp))), type="response")
```

```
##  1 
## NA
```

---

## Conclusions

- It is interesting that the highest probability is not recorded for maxima of all three inputs. Perhaps a larger study size could fix this.
- It should be noted that the probability is obtained as a ratio of the positive number of cases to the number of controls in the study
- Unfortunately, due to the way the study data is binned, we are not able to make predictions on any finer gradations of input.

