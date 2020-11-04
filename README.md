# Project: Can you recognize the emotion from an image of a face? 
<img src="figs/CE.jpg" alt="Compound Emotions" width="500"/>
(Image source: https://www.pnas.org/content/111/15/E1454)

### [Full Project Description](doc/project3_desc.md)

Term: Fall 2020

+ Team 6
+ Team members
	+ Mengyao He
	+ Qinzhe Hu
	+ Yiqi Lei
	+ Yuwei Tong
	+ Jiaqi Yuan

+ Project summary: In this project, we created a classification engine for facial emotion recognition. The goal of this project is to accurately classify an emotion shown from a facial image is single emotion or composed emotion. We started from a baseline model using the Gradient Boosting Machine. There are 6006 features in total, so we did feature selection, including forward stepwise selection, Lasso, and PCA, to reduce the dimention of the dataset. Then, we tried several different models, including Native Bayes, Random Forest, LDA, Xgboost, SVM, DNN. Models were evaluated in terms of accuracy and the area under the Receiver Operating Characteristic curve (AUC). Compare the results of each model, we chose Xgboost as our advanced model. 
	
**Contribution statement**: ([details](doc/a_note_on_contributions.md)) All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 

+ Mengyao He: Worked on featue selection, Neural Network, and Random Forest.
+ Qinzhe Hu: 
+ Yiqi Lei: Did the baseline model, collaborated on writing the main file (including the prediction part) with Yuwei. 
+ Yuwei Tong:  
+ Jiaqi Yuan:  
	

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
