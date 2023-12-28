# Install and load required packages
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

# Checking if data is loaded correctly:

if (is.null(cad1)) {
  stop("Data not loaded properly.")
}

# Error handling for Bayesian Network inference
tryCatch({
  cad.bn <- hc(cad1)
  net <- as(amat(cad.bn), "graphNEL")

  plot(net)

  names(cad1)
  
  block <- c(1, 3, 3, 4, 4, 4, 4, 1, 2, 1, 1, 1, 3, 2)
  blM <- matrix(0, nrow = 14, ncol = 14)
  rownames(blM) <- names(cad1)
  colnames(blM) <- names(cad1)

  for (b in 2:4) {
    blM[block == b, block < b] <- 1
  }
  blackL <- data.frame(get.edgelist(as(blM, "igraph")))
  names(blackL) <- c("from", "to")

  # Refit the network under new constraints
  cad.bn2 <- hc(cad1, blacklist = blackL)
  net.constr <- as(amat(cad.bn2), "graphNEL")

  # Plot the constrained network
  plot(net.constr)

  # Define and plot a directed acyclic graph
  cad.dag <- dag(~ CAD:Sex:Smoker:Inherit:Hyperchol +
                   AngPec:CAD +
                   Heartfail:CAD )
  plot(cad.dag)

  # Set and get findings
  cad.find1 <- setFinding(cad.bn, nodes = c("Sex", "Hyperchol"), states = c("Female", "Yes"))
  getFinding(cad.find1)

  # Define new evidence
  new_evidence <- list()
  new_evidence[["QWave"]] <- "Yes"
  new_evidence[["AMI"]] <- "Definite"
  pgm_1 <- bn.fit(bn, data = cad1)

  # Revising probabilities
  revised_cad_probability <- cpquery(pgm_1, event = (CAD == 'Yes'), evidence = new_evidence, method = 'lw')
  print(revised_cad_probability)

  # Bootstrap approach
  n_bootstraps <- 100
  learned_networks <- vector("list", n_bootstraps)

  for (i in 1:n_bootstraps) {
    boot_data <- cad1[sample(nrow(cad1), replace = TRUE), ]
    learned_networks[[i]] <- hc(boot_data)
  }

  # Summarize edges
  edge_table <- matrix(0, ncol = 2, nrow = 0)
  colnames(edge_table) <- c("Edge", "Frequency")

  for (net in learned_networks) {
    edges <- as.character(amat(net))
    edge_table <- rbind(edge_table, table(edges))
  }

  edge_summary <- aggregate(Freq ~ Var1 + Var2, data = edge_table, sum)
}, error = function(e) {
  cat("Error in Bayesian Network inference: ", e$message, "\n")
})
