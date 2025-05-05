# ACI MS3
Inference of Gene regulatory networks

## Optimization

The same human cell data can be predicted by DeepLearning networks. In this porject the graph auto encoder DeepRIG will be compared with a transformer model STGRNS.

Both DeepLearning networks optimize its function parameters with the Adam algorithm, approaching the minimal loss through gradient reduction.

DeepRIG calculates the L2-Loss.
STGRNS calculates the CrossEntropy Loss.

## Results
---
=======Evaluation of Dataset:  deeprig =======\
The AUC is: 0.9873 \
The AUPR is: 0.9922 \
The EPR is: 1.5598 \
The AUPR is: 0.9857 \
The AUPR ratio is: 1.6456

---

=======Evaluation of Dataset:  STGRNS =======\
ROC AUC: 0.6493 \
PR AUC: 0.1640 \
AUPR Ratio: 1.6397 \
Early Precision (Recall ≥ 0.1): 0.1000 \
Early Precision Ratio: 1.0000

---