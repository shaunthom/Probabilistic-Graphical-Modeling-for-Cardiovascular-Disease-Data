# Probabilistic-Graphical-Modeling-for-Cardiovascular-Disease-Data
The provided R code utilizes packages for probabilistic graphical modeling and Bayesian networks. 
It starts by inferring a Bayesian network structure from a dataset related to cardiovascular disease and visualizing it. It also imposes constraints on the network's edges based on predefined blocks and visualizes the constrained network. It proceeds to set evidence for specific nodes in the network, retrieve the set evidence, and fit a Bayesian network to the data. Finally, we calculate and prints a revised probability for a specific event (CAD being "Yes") given new evidence (values for "QWave" and "AMI" nodes) using conditional probability queries. I have showcasen operations involving Bayesian networks, structure learning, evidence handling, and probabilistic inference.

### Overview

This script illustrates how to construct, modify, and query Bayesian networks in R using packages like gRain, Rgraphviz, gRbase, ggm, gRim, bnlearn, and igraph. The example uses a dataset cad1 from the gRbase package.


### Main Steps

1. Network Inference: The script first infers a Bayesian network from the cad1 dataset using the Hill-Climbing (HC) algorithm from the bnlearn package.

2. Network Visualization: The inferred network is converted to a graphNEL object from the igraph package and plotted.

3. Block Constraints: The script imposes block constraints on the network, disallowing certain edges based on predefined blocks of variables.

4. Network Refitting with Constraints: The network is then refitted with these constraints using a blacklist of illegal edges.

5. Defining and Plotting a DAG: A Directed Acyclic Graph (DAG) is defined manually and plotted, showcasing another method of network creation.

6. Querying the Network: Setting and querying findings in the network. Revising probabilities in the network based on new evidence.


### Outputs:

These diagrams are like maps showing how certain health issues and habits can affect your heart, especially concerning coronary artery disease.

![img1](https://github.com/shaunthom/Probabilistic-Graphical-Modeling-for-Cardiovascular-Disease-Data/assets/134566032/0acf4c8e-9a6b-4f8c-b5fc-78e580c53266)

The arrows show the direction of influence between these factors. For example, it suggests that "Hyperchol" (high cholesterol) can lead to "CAD" (coronary artery disease), which in turn can lead to "Heartfail" (heart failure). It also shows that factors like smoking and genetics ("Inherit") are directly connected to CAD.

![img2](https://github.com/shaunthom/Probabilistic-Graphical-Modeling-for-Cardiovascular-Disease-Data/assets/134566032/65b51700-0e4a-4e74-873a-88f1f309ad32)

This diagram is a simplified version, focusing only on the most direct influences on CAD. It strips away the intermediate factors and shows only the main risk factors like "Sex", "Smoker", "Inherit", and "Hyperchol" affecting CAD, and then the outcomes "AngPec" (likely angina pectoris) and "Heartfail".

### What did the Model Showcase:

 • The ability of Bayesian networks to model complex dependencies among variables.

 • The flexibility of BNs in incorporating new information to update beliefs.

 • The practical application of BNs in understanding and visualizing data relationships.

 • The use of constraints to tailor the BN to specific knowledge or assumptions.

### Conclusion:

Through this mini-project, I have successfully demonstrated the capability to construct, visualize, modify, and query Bayesian networks, which are powerful tools for understanding complex probabilistic relationships in data. This project is a robust showcase of applying statistical concepts and programming skills to solve real-world problems in data analysis and probabilistic modeling.

#### Packages Used

gRain: For probabilistic graphical models.

Rgraphviz: For plotting graphical models.

gRbase, ggm, gRim: Provide tools for graphical models.

bnlearn: For learning Bayesian networks from data.

igraph: For network analysis and visualization.
