# lib
library(igraph)

# data
set.seed(1)
data <- matrix(sample(0:2, 15, replace=TRUE), nrow=3)
colnames(data) <- letters[1:5]
rownames(data) <- LETTERS[1:3]

# create the network object
network <- graph_from_incidence_matrix(data)

# plot it
plot(network)


plot(graph_from_incidence_matrix(mtcars))
