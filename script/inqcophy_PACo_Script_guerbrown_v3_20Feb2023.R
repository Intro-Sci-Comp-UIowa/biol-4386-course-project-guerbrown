## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## -----------------------------------------------------------------------------
parasitetree <- "//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/data/PACo/inqcophy_PACo_UCECO1SynTree_v02_guerbrown_22Feb2023.nex"
hosttree <- "//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/data/PACo/inqcophy_PACo_CynipidTree_v02_guerbrown_22Feb2023.nex"
assocdata <- "//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/data/PACo/inqcophy_PACo_AssociationMatrix_guerbrown_v6_20Feb2023.csv"


## ----Library Chunk------------------------------------------------------------
library(paco)
library(ape)
library(vegan)
library(phytools)
library(plotrix)
library(smacof)


## ----Synergus Import and Pruning, error = T-----------------------------------
svg("//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output/inqcophy_PACo_SynTree_v01_guerbrown_23Feb2023.svg")

#Import
p <- readNexus(parasitetree)

#Fixing tip labels. This is unnecessary but it's nice to make sure everything is plotting correctly

tiplabel_syn <- c("Synergus_sp.6", "S._punctatus_A", "S._campanula_A", "Synergus_sp.3", "Synergus_sp.7", "Synergus_sp.8",
                   "S._walshii_A", "S._erinacei_A", "S._erinacei_B", "S._villosus", "S._magnus", "Synergus_sp.2",
                   "S._ochreus", "S._oneratus_A", "S._oneratus_B", "S._oneratus_C", "S._coniferae", "S._lignicola",
                   "S._laeviventris_A", "S._laeviventris_B", "S._laeviventris_C")
p$tip.label <- tiplabel_syn

#Rooting the phylogeny based on a version of the tree with an outgroup and plotting
root.phylo(p, 1, resolve.root = T)
plot.phylo(p, align.tip.label = T, use.edge.length = F, root.edge = T)
dev.off()


## ----Cynipid Import and Pruning, error = T------------------------------------
svg("//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output/inqcophy_PACo_CynipTree_v01_guerbrown_23Feb2023.svg", width = 20, height = 10)

#Import
h <- read.nexus(hosttree)

tiplabel_gall <- c("Disholcaspis_quercusglobulus", "Disholcaspis_quercusmamma", "Acraspis_villosa", "Acraspis_quercushirta", "Acraspis_pezomachoides", "Acraspis_erinacei", "Druon_ignotum", "Druon_quercuslanigerum", "Cynips_conspicuus","Philonix_fulvicollis", "Atrusca_quercuscentricola", "Belonocnema_kinseyi", "Andricus_quercusstrobilanus", "Andricus_pisiformis", "Andricus_kingii", "Callirhytis_quercuspunctata", "Callirhytis_quercusventricosa", "Dryocosmus_minusculus", "Amphibolips_quercusostensackenii", "Amphibolips_quercusjuglans", "Amphibolips_cookii")
h$tip.label <- tiplabel_gall

root.phylo(h, 1, resolve.root = T)
plot.phylo(h, align.tip.label = T, use.edge.length = F, root.edge = T)
dev.off()


## ----fig.height=10, fig.width=20, fig.align='center', dev='svg'---------------
#Association matrix import
assoc <- read.table(assocdata, header = T, sep = ",")
#modifying the association matrix to make it readable by the program
hp <- as.data.frame.matrix(assoc)

#Removing underscores from the labels
h$tip.label <- gsub("_", " ", h$tip.label)
p$tip.label <- gsub("_", " ", p$tip.label)
hp$Gallers <- gsub("_", " ", hp$Galler)
hp$Synergus <- gsub("_", " ", hp$Synergus)

#plotting the tangelgram
svg("//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output/inqcophy_PACo_Tanglegram_v01_guerbrown_23Feb2023.svg", width = 20, height = 10)
cophyloplot <- cophyloplot(h, p, hp, show.tip.label = T,
lwd = 4, col = make.transparent("black", 0.3), font = 4,
length.line = 0, gap = -1, space = 135, rotate = F,  align.tip.label = T, 
use.edge.length = F, root.edge = T)+
text(5,19.7, "Cynipidae", cex = 1.2)+
text(168, 20.20, "Synergus", cex = 1.2)
dev.off()


## -----------------------------------------------------------------------------
#Change the two column association matrix into a binary association matrix. This is necessary to calculate principle coordinates in the statistical section.
hp_binary <- table(hp)
h_dist <- cophenetic(h)
p_dist <- cophenetic(p)

#Prepare PACo data and compute the result with 1,000 permutations.
D <- prepare_paco_data(h_dist, p_dist, hp_binary)
D <- add_pcoord(D)
D <- PACo(D, nperm=1000, seed = NA, method= "r0", proc.warning = F)


## -----------------------------------------------------------------------------
residuals_paco(D$proc)


## -----------------------------------------------------------------------------
HP.proc <- procrustes(D$H_PCo, D$P_PCo)
HostX <- HP.proc$X
ParY <- HP.proc$Yrot

#Let's make a few versions of the procrustes plot
#Here's one that has everything on it. If it's overwhelming to study, consider using identify() instead of text(). This will allow you to click and choose which points are labeled. 
svg("//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output/inqcophy_PACo_FullProcPlot_v01_guerbrown_23Feb2023.svg", width = 20, height = 10)
plot(HostX, asp=1, pch=120)
points(ParY, pch=1)
arrows(ParY[,1], ParY[,2], HostX[,1], HostX[,2], length=0.10, angle = 90, xpd=T)
HostX <- unique(HP.proc$X)
ParY <- unique(HP.proc$Yrot)
text(ParY[,1], ParY[,2], rownames(ParY), offset=0.3, xpd=F, cex=0.7)
text(HostX[,1], HostX[,2], rownames(HostX),offset=0.3, xpd=F, cex= 0.7) 
dev.off()

#Now, here's one without the lines and just Synergus
svg("//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output/inqcophy_PACo_SynProcPlot_v01_guerbrown_23Feb2023.svg", width = 20, height = 10)
plot(HostX, asp=1, pch=120)
points(ParY, pch=1)
HostX <- unique(HP.proc$X)
ParY <- unique(HP.proc$Yrot)
text(ParY[,1], ParY[,2], rownames(ParY), offset=0.3, xpd=F, cex=0.7)
dev.off()

#And here's another with just the Cynipid taxa
svg("//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output/inqcophy_PACo_CynProcPlot_v01_guerbrown_23Feb2023.svg", width = 20, height = 10)
plot(HostX, asp=1, pch=120)
points(ParY, pch=1)
HostX <- unique(HP.proc$X)
ParY <- unique(HP.proc$Yrot)
text(HostX[,1], HostX[,2], rownames(HostX),offset=0.3, xpd=F, cex= 0.7)
dev.off()


## ----fig.height=7.5, fig.width=20, fig.align='center', dev='svg'--------------
NLinks = 25
SQres <- sort(residuals_paco(D$proc))
SQres.jackn <- SQres**2
SQres <- (residuals (HP.proc)**2)
SQres.jackn <- SQres.jackn*(-(NLinks-1))
SQres.jackn <- SQres.jackn*-1
SQres <- SQres*NLinks
SQres <- as.matrix(SQres)
SQres.jackn <- as.data.frame(SQres.jackn)
SQres.jackn <- t(apply(SQres.jackn, 1, "+", SQres))
phi.mean <- apply(SQres.jackn, 2, mean, na.rm = TRUE)
phi.UCI <- apply(SQres.jackn, 2, sd, na.rm = TRUE)
t.critical = qt(0.975, NLinks-1) 
phi.UCI <- phi.mean + t.critical * phi.UCI/sqrt(NLinks)
phi.UCI

svg("//wsl.localhost/Ubuntu/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output/inqcophy_PACo_ResBarplot_v01_guerbrown_23Feb2023.svg", width = 20, height = 7.5)
par(mar = c(7, 5, 3, 6))
pat.bar <- barplot(sort(phi.mean), names.arg = "", space = 0.2, col="white", ylab= "Squared residuals", ylim=c(0, max(phi.UCI)),cex.lab=1)
segments(pat.bar, sort(phi.mean), pat.bar, sort(phi.UCI), lwd = 1.5)
arrows(pat.bar, sort(phi.mean), pat.bar, sort(phi.UCI), lwd = 1.5, angle = 90, code = 3, length = 0.05)
abline(a=median(phi.mean), b=0, lty=2) 
text(pat.bar, par("usr")[3] - 0.001, srt = 330, adj = 0, labels = rownames(SQres.jackn), xpd = TRUE, font = 3, cex=0.65, las = 2)
text(22.32, 0.05, '*', cex = 3)
text(25.93, 0.053, '*', cex = 3)
dev.off()


## -----------------------------------------------------------------------------
h_matrix <- compute.mr(h)
h_df <- as.data.frame(h_matrix)
host.D <- cophenetic(h)
para.D <- cophenetic(p)
parafit <- parafit(sqrt(host.D), sqrt(para.D), hp_binary, test.links = T, correction = "none", nperm = 1000)
print(parafit)


## -----------------------------------------------------------------------------
parafit <- parafit(host.D, para.D, hp_binary, test.links = T, correction = "cailliez", nperm = 1000)
print(parafit)


## -----------------------------------------------------------------------------
parafit <- parafit(host.D, para.D, hp_binary, test.links = T, correction = "lingoes", nperm = 1000)
print(parafit)

