
#install.packages('igraph')
library(gRain)
#library(RHugin)
library(Rgraphviz)
library(gRbase)
library(ggm)
library(gRim)
library(bnlearn)
library(igraph)

data(cad1, package = "gRbase")


# Infer a BN
cad.bn <- hc(cad1)
net <- as(amat(cad.bn), "graphNEL")

#Plot the "best" network
plot(net)

names(cad1)
block <- c(1, 3, 3, 4, 4, 4, 4, 1, 2, 1, 1, 1, 3, 2) #assign variables a block
blM <- matrix(0, nrow = 14, ncol = 14)
rownames(blM) <- names(cad1)
colnames(blM) <- names(cad1)

# fill in the illegal edges
for (b in 2:4){
	blM[block == b, block < b] <- 1
}
blackL <- data.frame(get.edgelist(as(blM, "igraph")))
names(blackL) <- c("from", "to")

#Refit the network under the new constraints 
cad.bn2 <- hc(cad1, blacklist = blackL)
net.constr <- as(amat(cad.bn2), "graphNEL")

plot(net.constr)

plot(net)


cad.dag <- dag(~ CAD:Sex:Smoker:Inherit:Hyperchol +
                 AngPec:CAD +
                 Heartfail:CAD )
plot(cad.dag)


cad.find1<-setFinding(cad.bn , nodes = c("Sex","Hyperchol"),states = c("Female","Yes"))
getFinding(cad.find1)
getfinding


new_evidence <- list()
new_evidence[["QWave"]] <- "Yes"
new_evidence[["AMI"]] <- "Definite"
pgm_1 <- bn.fit(bn, data = cad1)

# revising probabilities:

revised_cad_probability = cpquery(pgm_1, event = (CAD == 'Yes'), evidence = new_evidence, method = 'lw')
print(revised_cad_probability)
