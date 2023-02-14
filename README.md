# Computational Cophylogenetic and Discrete Trait Analysis of a Genus of Oak Gall Inquilines
### This work is for BIOL 4386 (Introduction to Scientific Computing) during the Spring 2023 semester. This repository aims to understand evolution of Synergus inquilines with respect to ecology and comparative phylogenetics. All analysis was performed under R 4.2.2 and is adapted from both [Balbuena et al., 2013](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0061048) and [Revell & Harmon (2022)](https://press.princeton.edu/books/paperback/9780691219035/phylogenetic-comparative-methods-in-r). 
***

### Introduction/Background
The processes that structure an ecological community often have complex interconnections. Understanding these is a fundamental challenge of ecology. Oak gallwasps, or Cynipids (family Cynipidae), are just one example of these perplexingly diverse systems. Cynipids are small hymenopterans that oviposit, or lay eggs, into tissues of oak trees. These eggs hatch and the emergent larvae feed on surrounding plant tissue where their salivary secretions induce gall formation from the plant tissue. These structures can be highly diverse in size, shape, texture, and location. Moreover, these structures are frequently attacked by parasitoids and other insects known as inquilines. Traditionally, inquilines are defined as organisms that take advantage of a previously established habitat or burrow. However, in oak gallwasps, inquiline adults oviposit into the formed gall and the emergent inquiline larvae will feed on the gall tissue until pupation. In a system with such extensive cohabitation and parasitoidism, it is reasonable to suspect that taxa interacting with gallwasps are also cospeciating or that there is some cophylogenetic signal. In this analysis, we aim to statistically understand these interactions and determine if there is a signal of cospeciation/cophylogney between a single inquiline genus, Synergus, and their assocated Cynipids.

### Figure(s)
This analysis will first require me to complete a procrustean analysis of Synergus and Cynipidae using the R package "PACo" to produce a statistic that represents the signal of *cophylogeny* through essentially topographic superimposition of one phylogenetic tree onto another. This process also entails performing a ParaFitGlobal statistical test which will represent the global signal of coevolution. The output from these two procedures includes a tanglegram of the Synergus and Cynipidae phylogenetic trees showing, visually, the associations. This analysis also producues a barplot of the residuals after the PACo analysis. I plan to show both with some aestetic corrections as panels A and B of the figure. I have already completed most of this analysis but will need to organize files make the script streamline. 

If there is sufficient time after creating the intitial part of this analysis with version control, I will move on to a second analysis of the data. This will entail modeling trait characteristics of Cynipidae to the Synergus phylogeny and using best fit/maximum likelyhood tests to computationally simulate ancestral traits on the Synergus phylogeny. The panels for this analysis are described below:

Panels C and D of this figure will be part of the discrete trait analysis for Synergus. Here, I will use traits of the galls that each Synergus species is known to associate with (i.e. gall produces nectar, woody, found on leaf, etc.) and run multiple different models that could explain evolution towards these traits. These models create diagrams that show the likelyhood of a trait changing from one to another. This will likely become panel C. Finally, I will test these models against each other using maximum likelyhood tests and use the best fit model to computationally simulate ancestral states for two or three different traits. The Synergus tree is relatively small so this may become 2 or three different trees depending on the amount of room that is available to display the distribution of these traits on one large phylogeny. 

### Materials and Methods
For this analysis, we use a mixture of .tre/.nwk files created from concatenated ultra-conserved elements (UCE) and cytochrome oxidase subunit 1 (CO1) data of Synergus and Cynipidae along with multiple matrices of either associations of character traits. The statistical computation was completed entirely in R version 4.2.2 using the packages "PACo", "geiger", "phytools", "ape", and "lmtest".

To perform PACo analysis of cophylogeny, we will first begin by accessing the data in R Studio using R Markdown. Next, we will plot the phylogenies for Synergus and Cynipidae facing each other and use data from an association matrix to draw lines of association. This will allow us to visualize the data and determine if there are any taxa with missing assocations (taxa with missing values will return an error in later sections). Next, we will reorder the association data into a matrix that the program can read. Lastly, we will use the quantitative values of the branches from both phylogenies to create a matrix of patristic distances using the function 'cophenetic()'.

Once all three of these matrices have been created, we can complete the PACo analysis of cophylogeny set to 10,000 permutations. This analysis will also require us to correct for negative eigenvalues that will result from a shape superimposition of the phylogenies. To correct these, we will complete a manual correction using square roots, the "Cailliez" correction, and the "Lingoes" Correction. We will choose the most conservative correction from these three to interpret. The tests will return a Pearson's coefficient and a sum-of-squares value. We will extract values of the residuals from the analysis and plot them on a bar graph while drawing the line of best fit as a flat linear value going through the middle of the plot. Lastly, Babluena et al., (2013) recommends we perform a ParaFitGlobal statistical test on the data to determine if there is a signal of "host-parasite coevolution". This will provide a list of statistical values for each association between Synergus and Cynipidae along with a value for coevolution in the entire comparison. We will mark any associations that are significant from this test on the bar graph of residuals.

#### References
Authors: Guerin Brown, Andrew Forbes, PhD, and Miles Zhang, PhD    
Laboratories: Forbes Lab (University of Iowa) 

**Citations to Literature and Packages:** 

**Literature**
 
* **Phylogenetic Comparative Methods in R**: Revell, L. J. (2022). "Phylogenetic comparative methods in R." *Princeton University Press*. 
* **PACo: A Novel Procrustes Application to Cophylogenetic Analysis**: Balbuena JA, Míguez-Lozano R, Blasco-Costa I (2013) "PACo: A Novel Procrustes Application to Cophylogenetic Analysis." *PLOS ONE* 8(4): e61048. https://doi.org/10.1371/journal.pone.0061048

**Packages** 

* **Phytools**: Revell LJ (2012). "phytools: An R package for phylogenetic
  comparative biology (and other things)." *Methods in Ecology and Evolution*, 3, 217-223.
* **Geiger**: Harmon L, Weir J, Brock C, Glor R, Challenger W (2008). "GEIGER: investigating evolutionary radiations." *Bioinformatics*, 24, 129-131.
* **PACo**: Balbuena JA, Míguez-Lozano R, Blasco-Costa I (2013) "PACo: A Novel Procrustes Application to Cophylogenetic Analysis." *PLoS ONE* 8(4): e61048. https://doi.org/10.1371/journal.pone.0061048
* **lmtest**: Zeileis A, Hothorn T (2002). "Diagnostic Checking in Regression Relationships." *R News*, 2(3), 7-10. https://CRAN.R-project.org/doc/Rnews/.
