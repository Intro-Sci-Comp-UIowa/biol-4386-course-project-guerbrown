## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----Library Chunk------------------------------------------------------------
library(paco)
library(ape)
library(vegan)
library(phytools)
library(plotrix)


## ----Synergus Import and Pruning, error = T-----------------------------------
syntree <- read.tree("~/github_local/biol-4386-course-project-guerbrown/data/PACo/inqcophy_PACo_UCECO1SynTree_guerbrown_v1_20Feb2023.nwk")
tip1 <- c("Cer_1014_055_2A", "Diastrophus_turgidus_1322311", "Rhoophilus_loewi_1322293",
          "Synergus_punctata_702_002_3", "Synergus_campanula_701_019_64C", "Synergus_539_067_12",
          "Synergus_punctata_1025_023_2B", "Synergus_punctata_630_023_4A", "Synergus_punctata_994_023_1",
          "Synergus_1486_126_1", "Synergus_1497_141_4A", "Synergus_1515_141_2", "Synergus_1589_160_36A",
          "Synergus_walshii_362_024_1C", "Synergus_erinacei_1105_003_10A", "Synergus_villosa_B_1206_004_2",
          "Synergus_magnus_1137_110_2", "Synergus_magnus_1140_108_7", "Synergus_1553_005_1",
          "Synergus_oneratus_1196_023_1", "Synergus_oneratus_566_023_1", "Synergus_oneratus_52_3_3b",
          "Synergus_oneratus_462_023_3", "Synergus_oneratus_546_019_22", "Synergus_oneratus_695_020_1",
          "Synergus_oneratus_1105_003_5A", "Synergus_oneratus_442_002_2D", "Synergus_oneratus_1201_003_2",
          "Synergus_oneratus_556_065_1", "Synergus_sp2_1322294", "Synergus_unknown_sp1_698_999_10C",
          "Synergus_davisi_1076_101_13A", "Synergus_sp1_1322283", "Synergus_leviventris_1081_006_3",
          "Synergus_leviventris_1221_006_1A", "Synergus_leviventris_1221_006_2B", "Synergus_leviventris_1164_110_3A",
          "Synergus_leviventris_791_045_11B", "Synergus_leviventris_791_045_6A", "Synergus_leviventris_960238",
          "Synophrus_pilulae_961203", "An_quercuspetiolicola_861_042_23B", "Neuroterus_floccosus_1552_022_6",
          "Synergus_1059_024_6", "Synergus_1523_145_5", "Synergus_campanula_631_005_3B",
          "Synergus_punctata_642_009_21A", "Synergus_walshii_115_1_4", "Synergus_1449_034_1",
          "Synergus_davisi_1076_101_14A")
p <- drop.tip(syntree, tip1, trim.internal = T)
tiplabel_syn <- c("Synergus_sp.6", "S._punctatus_A", "S._campanula_A", "Synergus_sp.3", "Synergus_sp.7", "Synergus_sp.8",
                   "S._walshii_A", "S._erinacei_A", "S._erinacei_B", "S._villosus", "S._magnus", "Synergus_sp.2",
                   "S._ochreus", "S._oneratus_A", "S._oneeratus_B", "S._oneratus_C", "S._coniferae", "S._lignicola",
                   "S._laeviventris_A", "S._laeviventris_B", "S._laeviventris_C")
p$tip.label <- tiplabel_syn


## ----Cynipid Import and Pruning, error =T-------------------------------------
main2 <- read.tree("~/github_local/biol-4386-course-project-guerbrown/data/PACo/inqcophy_PACo_CynipidTree_guerbrown_v1_20Feb2023.nwk")
tip2 <- c("Disholcaspis_sp_AZ", "Disholcaspis_endura", "Disholcaspis_quercusvirens", "Disholcaspis_cinerosa", "Andricus_brunneus", "Burnettweldia_washingtonensis", "Disholcaspis_lasia", "Cynips_plumbea", "Neutoerus_vesicula", "Atrusca_bella", "Xanthoteras_eburneum", "Andricus_quercuscalifornicus", "Unkown_hidden_white_bud", "Andricus_parmula", "Andricus_bakkeri", "Andricus_pedicellatum", "Callirhytis_pentagonal_cluster", "Callirhytis_vaccinii", "Holocynips_hartmani", "Callirhytis_quercusfutilis", "Bassettia_pallida", "Andricus_quercusutriculus", "Andricus_coortus", "Andricus_foliaformis", "Andricus_quercusfoliatus", "Andricus_sphaericus", "Andricus_quercuspetiolicola", "Callirhytis_quercusoperator", "Callirhytis_pulchra", "Callirhytis_quercuscornigera", "Callirhytis_pigra", "Callirhytis_scitula", "Zaqpatella_davisae", "Dryocosmus_quercusnotha", "Dryocosmus_cinereae", "Dryocosmus_quercuspalustris", "Zophoteras_sphaerula","Kokkocynips_imbricariae", "Callirhytis_attigua", "Amphibolips_hidalgeonsis", "Amphibolips_globulus", "Amphibolips_confluenta", "Amphibolips_quercusinanis", "Dryocosmus_rileypokei","Callirhytis_glandulus", "Andricus_chinquapin", "Atrusca_brevipennata", "Melikaiella_ostensackeni", "Melikaiella_tumifica", "Loxaulus_quercusmammula", "Andricus_operatus", "Neuroterus_saltatorius", "Neuroterus_saltatorius_texanus", "Neuroterus_quercusirregularis", "Callirhytis_exigua", "Neuroterus_distortus", "Neuroterus_pallidus", "Neuroterus_quercusverrucarum", "Neuroterus_quercusminutissimus", "Callirhytis_flavipes", "Neuroterus_flower_swelling", "Neuroterus_quercusbatatus", "Neuroterus_valhalla", "Neuroterus_fragilis", "Neuroterus_washingtonensis", "Disholcaspis_edura", "Disholandricus_lasia", "Belonocnema_fossoria", "Unknown_hidden_white_bud", "Callirhytis_quercusbatatoides", "Zapatella_davisae", "Zophoteras_sphaerula", "Amphibolips_hidalgoensis", "Andricus_opertus", "Neuroterus_vesicula", "Zopheroteras_sphaerula", "Druon_quercusflocci", "Andricus_biconicus", "Callirhytis_seminator", "unk_bud_gall_Q._macrocarpa", "Amphibolips_nubilipennis")
h <- drop.tip(main2, tip2, trim.internal = T)
tiplabel_gall <- c("Disholcaspis_quercusglobulus", "Disholcaspis_quercusmamma", "Acraspis_villosa", "Acraspis_quercushirta", "Acraspis_pezomachoides", "Acraspis_erinacei", "Acraspis_erinacei", "Druon_quercuslanigerum", "Cynips_conspicuus", "Philonix_fulvicollis", "Atrusca_quercuscentricola", "Belonocnema_kinseyi", "Andricus_quercusstrobilanus", "Andricus_pisiformis", "Andricus_kingii", "Callirhytis_quercuspunctata", "Callirhytis_quercusventricosa", "Dryocosmus_minusculus", "Amphibolips_quercusostensackenii", "Amphibolips_quercusjuglans", "Amphibolips_cookii")
h$tip.label <- tiplabel_gall


## -----------------------------------------------------------------------------
assoc <- read.csv("~/github_local/biol-4386-course-project-guerbrown/data/PACo/inqcophy_AssociationMatrix_v6_guerbrown_20Feb2023.csv")
hp <- as.data.frame.matrix(assoc)
cophy <- cophylo(h, p, hp)
plot(cophy, link.type = "straight" ,link.lwd=4,
     link.lty="solid",link.col=make.transparent("black",
     0.2))


## -----------------------------------------------------------------------------
hp_binary <- table(hp)
h_dist <- cophenetic(h)
p_dist <- cophenetic(p)
D <- prepare_paco_data(h_dist, p_dist, hp_binary)
D <- add_pcoord(D)
D <- PACo(D, nperm=1000, seed = NA, method= "r0", proc.warning = F)
print(D$gof)


## -----------------------------------------------------------------------------
residuals_paco(D$proc)


## ----eval=FALSE, include=FALSE------------------------------------------------
## h$tip.label <- gsub("_", " ", h$tip.label)
## p$tip.label <- gsub("_", " ", p$tip.label)
## hp$Gallers <- sub("_", " ", hp$Galler)
## hp$Synergus <- sub("_", " ", hp$Synergus)
## cophyloplot(h, p, hp, show.tip.label = T, use.edge.length = F,
## lwd = weight4, col = make.transparent("black", 0.3), font = 3,
## length.line = 0, gap = 1, space = 135, rotate = F)
## text(5,19.7, "Cynipidae", cex = 1.2)
## text(168, 20.20, "Synergus", cex = 1.2)


## -----------------------------------------------------------------------------
HP.proc <- procrustes(D$H_PCo, D$P_PCo)
HostX <- HP.proc$X
ParY <- HP.proc$Yrot
plot(HostX, asp=1, pch=120)
points(ParY, pch=1)
arrows(ParY[,1], ParY[,2], HostX[,1], HostX[,2], length=0.12, angle=15,
xpd=FALSE)
HostX <- unique(HP.proc$X)
ParY <- unique(HP.proc$Yrot)
identify(ParY[,1], ParY[,2], rownames(ParY), offset=0.3, xpd=F, cex=0.8)
identify(HostX[,1], HostX[,2], rownames(HostX),offset=0.3, xpd=T, cex= 0.8) 


## -----------------------------------------------------------------------------
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
par(mar = c(7, 5, 3, 6))
pat.bar <- barplot(sort(phi.mean), names.arg = "", space = 0.2, col="white", ylab= "Squared residuals", ylim=c(0, max(phi.UCI)),cex.lab=1.2)
segments(pat.bar, sort(phi.mean), pat.bar, sort(phi.UCI), lwd = 1.5)
arrows(pat.bar, sort(phi.mean), pat.bar, sort(phi.UCI), lwd = 1.5, angle = 90, code = 3, length = 0.05)
abline(a=median(phi.mean), b=0, lty=2) 
text(pat.bar, par("usr")[3] - 0.001, srt = 330, adj = 0, labels = rownames(SQres.jackn), xpd = TRUE, font = 1, cex=1.2, las = 1)
text(22.32, 0.05, '*', cex = 3)
text(25.93, 0.053, '*', cex = 3)



## -----------------------------------------------------------------------------
h_matrix <- compute.mr(h)
h_df <- as.data.frame(h_matrix)
host.D <- cophenetic(h)
para.D <- cophenetic(p)
parafit <- parafit(sqrt(host.D), sqrt(para.D), hp_binary, test.links = T, correction = "none", nperm = 10000)
print(parafit)


## -----------------------------------------------------------------------------
parafit <- parafit(host.D, para.D, hp_binary, test.links = T, correction = "cailliez", nperm = 10000)
print(parafit)


## -----------------------------------------------------------------------------
parafit <- parafit(host.D, para.D, hp_binary, test.links = T, correction = "lingoes", nperm = 10000)
print(parafit)

