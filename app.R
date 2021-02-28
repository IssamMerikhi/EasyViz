# Import requierments :

library(stats)
library(factoextra)
library(scales)
library(grDevices)
library(FactoMineR)
library(tibble)

# Data Processing :

# On importe la base
# On supprime la colonne ID
# On enlève les 300 lignes de NA
# Pour des soucis de viz, on garde que les 100 premiers clients
# On scale la base

dataset <- read.csv("C:/Users/Elève/Desktop/projet Trabelsi/marketing_data.csv")
dataset = subset(dataset, select = -c(CUST_ID) )
dataset <- dataset[complete.cases(dataset), ]
dataset = dataset[c(1:100),]
df.scaled <- scale(dataset)


# K-means :

# On créer l'objet K means grâce à la fonction kmeans avec 4
# clusters, choisi grâce à la elbow méthode

res.km <- kmeans(df.scaled, centers = 4)

# Visualisation du K-means

# On met notre K means comme argument et nos données
# palette c'est la couleur
# geom = est ce qu'on met des points, des croites des étoiles etc...
# ellipse va entourer les clusters
# ggtheme est un theme qui me plait

fviz_cluster(res.km, data = df.scaled,
             palette = "jco", 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
)

res.km$cluster


# Dendrogram :

# On calcule les distances entre les observations
# On créer les dendrogram grace a hclust 
# On choisit la méthode de clustering (complete, average, single, ward)

res.dist = dist(x = df.scaled, method = "euclidean")

complete.hc = hclust(d = res.dist,
                method = "complete")
average.hc = hclust(d = res.dist,
                    method = "average")
min.hc = hclust(d = res.dist,
                method = "single")

ward.hc = hclust(d = res.dist,
                method = "ward.D2")

# Visualisation Dendrogram :

# k = nb de clusters
# k_colors = couleurs des clusters
# rect pour faire des rectangles par rapport au cluster
# rect_fill pour remplir les rectanles
# rect_border = couleurs rect
# ggtheme = theme de ggplot qui m'a plu
# type = type de dendrog ( rectrangle, circular, phylogenic)
# repel = TRUE => les labels ne se chevauchent pas

par(mfrow = c(1,2))

fviz_dend(x = complete.hc,
          cex = 0.7,
          lwd = 0.7,
          k = 4,
          k_colors = "jco",
          rect = TRUE,
          rect_fill = TRUE,
          rect_border = "jco",
          ggtheme = theme_bw()
          )

fviz_dend(x = ward.hc,
          cex = 0.7,
          lwd = 0.7,
          k = 4,
          k_colors = "jco",
          rect = TRUE,
          rect_fill = TRUE,
          rect_border = "jco",
          ggtheme = theme_bw()
          
)


fviz_dend(x = ward.hc,
          cex = 0.7,
          lwd = 0.7,
          k = 4,
          k_colors = "jco",
          rect = TRUE,
          rect_fill = TRUE,
          rect_border = "jco",
          ggtheme = theme_bw(),
          type = "phylogenic",
          repel = TRUE
          
)

fviz_dend(x = ward.hc,
          cex = 0.7,
          lwd = 0.7,
          k = 4,
          k_colors = "jco",
          rect = TRUE,
          rect_fill = TRUE,
          rect_border = "jco",
          ggtheme = theme_bw(),
          type = "circular",
          repel = TRUE
          
)
# PCA :

# t est le vecteur de cluster (soit 1, 2, 3 ou 4)
# On crée l'ACP grâce à la fonction PCA

t = as.matrix(res.km$cluster)
zZ.pca <- PCA(df.scaled, graph = FALSE)
fviz_eig(zZ.pca, addlabels = TRUE,ggtheme = theme_bw(), ylim = c(0, 50))
var = get_pca(zZ.pca, element = c("var", "ind"))


# Visualisation du PCA

# On met notre pca en argument
# col.ind on choisit les couleurs par rapports a nos clusters
# palette c'est les différentes couleurs
# addElipses on rajotue ellispes autour clusters
# legend.title le titre de la legende

fviz_pca_ind(zZ.pca,
             geom.ind = "point", # Montre les points seulement (mais pas le "text")
             col.ind = as.factor(t), # colorer by groups
             palette = "jco",
             addEllipses = TRUE, # Ellipses de concentration
             legend.title = "Clusters")



fviz_pca_biplot(zZ.pca, 
                geom.ind = "point",
                pointshape = 21,
                pointsize = 2.5,
                palette = "jco",
                fill.ind = as.factor(t),
                col.ind = as.factor(t),
                col.var = "black",
                label = "var",
                repel = TRUE,
                legend.title = list(fill = "Clusters", color = "Clusters"))


fviz_pca_biplot(zZ.pca, 
                # Individus
                geom.ind = "point",
                fill.ind = as.factor(t), col.ind = "black",
                pointshape = 21, pointsize = 2,
                palette = "jco",
                addEllipses = TRUE,
                # Variables
                alpha.var ="contrib", col.var = "contrib",
                gradient.cols = "RdYlBu",
                label = "none",
                
                legend.title = list(fill = "Clusters", color = "Contrib",
                                    alpha = "Contrib"))


