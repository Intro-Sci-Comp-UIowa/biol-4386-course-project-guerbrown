# Evolution of a genus of gall wasp kleptoparasites 
### This work is for BIOL 4386 (Introduction to Scientific Computing) during the Spring 2023 semester. This repository aims to understand evolution of Synergus kleptoparasites with respect to ecology and comparative phylogenetics. All analysis was performed under R 4.2.2 and is adapted from both [Balbuena et al., 2013](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0061048) and [Revell & Harmon (2022)](https://press.princeton.edu/books/paperback/9780691219035/phylogenetic-comparative-methods-in-r). 
***

## Introduction/Background
Kleptoparasites do not directly parasitize their hosts but instead steal food and resources, reducing host fitness. Like direct parasites, kleptoparasites can be highly dependent on their hosts such that their evolutionary histories may be linked. Here, we study the evolution of a kleptoparasitic wasp genus, *Synergus* (Hymenoptera: Cynipidae: Synergini), in relation to their hosts, oak gall wasps (Hymenoptera: Cynipidae: Cynipini). Ovipositing oak gall wasps induce the formation of galls on oaks (Fagaceae) that provide food and shelter to one or more developing gall wasps. Galls induced by different gall wasp species are diverse in size, shape, color, and location on the host tree, and tend to be specific to just one or a few oak tree species. *Synergus*, and other kleptoparasites, exploit galls by ovipositing into the developing gall and inducing the development of a secondary gall chamber. *Synergus* larva feed on the gall tissue, sometimes reducing food available to the oak gall wasp larva to the extent that the host dies. We ask how the ecology of gall wasps has affected the diversification of *Synergus*. We compare the topologies of *Synergus* and gall wasp phylogenetic trees and detect a significant signal of cophylogeny, or congruence of the evolutionary relationships, that appears limited to only a few interactions. We use traits of oak galls to describe the ecological niche for each Synergus species and reconstruct ecological traits of ancestral nodes. 
***
## Figure(s)
**PACo and Cophylogeny:**
The first part of this analysis uses a "procrustean approach to cophylogeny" (PACo; Balbuena *et al.*, 2013; Hutchinson *et al.*, 2017). This analysis takes the topology of two phylogenetic trees, usually a host and a parasite, and compares the shapes in a graphical plane. This involves shifting coordinates, or values, that define the shapes and superimposing them onto one another (also known as procrustean superimposition). So, it does not matter if the values that graphically define a shape are smaller than another, everything is shifted in proportionally so that both shapes can be compared in the same virtual space. Once superimposed, a value of the similarity can be extracted. In PACo, this is value of cophylogeny that describes whether there is congruence between the shape of two phylogenetic trees. This can also be represented using an additional test known as a ParaFitGlobal which provides a value of coevolution (Legendre *et al.*, 2002). While PACo provides a value of whether there is shape congruence, ParaFitGlobal provides a value to determine if there is a signal of coevolution. This can be defined as divergence occurring between two associated clades wherein divergence of a host, for example, results in divergence of the parasite. 

These analyses produce two major figures. The first is a tanglegram, which shows associations between the trees of Cynipini and *Synergus* (Fig. 1A). In this image, any line between the two inwardly facing phylogenies represents an ecological association. The second figure is a bar plot of residuals from the PACo analysis (Fig. 1B). Because PACo is superimposing the shapes of two phylogenies, each association is given a numerical value that represents how similar that association is to a model of best fit. These values can be plotted as a bar plot with a line going through the middle of the plot showing the median value of the residuals. In this image it is possible to visually determine how much a particular association between host and kleptoparasite varies from perfect congruence. Additionally, we can also extract values of coevolution for specific associations from the ParaFitGlobal test and mark any that are statistically significant with asterisks in the bar plot. 

**Discrete Trait Analysis and Ancestral State Reconstruction:** 
The second part of this analysis attempts to visualize how physical traits or characteristics of oak gall wasps might constrain or affect evolution of *Synergus* kleptoparasites. This involves associating a particular trait of an oak gall wasp to its corresponding *Synergus* taxa. For example, we can associate the location an oak gall wasp forms galls on an oak tree (i.e., leaf, stem, bud, or fruit) to the corresponding *Synergus* that parasitizes that oak gall wasp. After completing this for each *Synergus* species, we can perform tests that attempt to simulate how these traits may have arisen at terminal nodes of the phylogeny. These tests utilize models to describe how traits evolve. For example, the "equal rates" (ER) model simulates evolution of the traits using the assumption that the likelihood of changing from one trait to another is uniform for all variations of that trait. Other models exist such as the "all-rates different" (ARD) model where each variation of a trait has a unique probability of being gained or lost evolutionarily. Each model has a corresponding AIC (Akaike Information Criterion) value that determines how close of a fit it is to the expected result at the terminal nodes, or how likely it is to be accurate in predicting them. We can perform multiple of these tests and choose the model with the lowest AIC value to ensure statistical accuracy. Once chosen, we can then use this model to simulate evolution of a particular trait thousands of times and estimate the probability that an ancestral taxon, represented by an internal node, would have a given variation of a trait. Finally, these can be represented, or *reconstructed*, on a phylogeny as miniature pie charts that show the probability of an ancestral taxa having a certain trait (Fig. 1C-F). 

We will complete this for traits such as gall size, presence of spines on the gall, texture of the gall, hairiness, whether it produces nectar, whether it is fibrous or not, location on the oak tree, seasonality, and the taxonomic section of the oak. Once the models have been decided, we will map these traits onto fan phylogenies and show those that most accurately describe evolution of *Synergus*. Others will be provided in a supplement in a git repository. 

![example_figure.png](https://github.com/Intro-Sci-Comp-UIowa/biol-4386-course-project-guerbrown/blob/main/_resources/example_figure.png)
Figure 1. A) Tanglegram showing associations between *Synergus* and Cynipini. B) Bar plot of residuals for each association from the PACo analysis. The dotted horizontal line depicts the median squared residual. Error bars are shown with each association. Associations that were significant in ParaFit are marked with asterisks. C-F) Preliminary example of what the ancestral state reconstructions will look like. Each one presented now is the exact same image but in future versions, this will have multiple different traits instead of just one presented four times. Four phylogenies are only shown here to better visualize how the overall figure will be laid out. 

*** 

## Materials and Methods
For this analysis, we utilize phylogenetic trees created from concatenated ultra-conserved elements (UCE) and cytochrome oxidase subunit 1 (CO1) data of *Synergus* and Cynipini along with multiple matrices of associations and character traits. The statistical computation was completed entirely in R version 4.2.2 using the packages "PACo", "geiger", "phytools", "ape", "corHMM", and "lmtest".

To perform PACo analysis of cophylogeny, we will first begin by accessing the data in R Studio using R Markdown. Next, we plot the phylogenies for *Synergus* and Cynipini facing each other and use data from an association matrix to draw lines of association. This will allow us to visualize the data and determine if there are any taxa with missing associations (taxa with missing values will return an error in later sections). Next, we will reorder the categorical association data into a numerical binary matrix that the program can read. This step can be done manually while collecting the data but does not have to be. Lastly, we will use the quantitative values of the branches from both phylogenies to create a matrix of patristic distances, or sums of the branch lengths that link nodes.

Once all three of these matrices have been created, we can complete the PACo analysis of cophylogeny set to 10,000 permutations/simulations. Since we are forcing a shape change between two objects, one object may be shifting in a negative direction which will result in a negative eigenvalue, or scalar factor of transformation. Negative eigenvalues cannot be read when performing the ParaFitGlobal analysis of coevolution as they do not represent 'real space' so must correct them. To do this, we will complete a manual correction using square roots, the "Cailliez" correction, and the "Lingoes" correction (Hutchinson *et al.*, 2017). We will choose the most conservative correction from these three to interpret. We will extract values of the residuals from the analysis and plot them on a bar graph while drawing the line of best fit as a flat linear value going through the middle of the plot. 

To complete the ancestral state reconstruction, we begin by creating a table of *Synergus* kleptoparasites and adding traits of the Cynipini they parasitize. Once this is established, we can perform two variations of our modeling testing procedures-- one for polymorphic traits and one for binary traits. Both variations result in the same models being tested, the only difference is how the traits are treated. In binary models, the trait can only be one or the other, it cannot be a mixture of the two (i.e. leaf or bud). In polymorphic traits, all traits *and* any intermediate states are considered individual traits (i.e. leaf, bud, leaf+bud). We choose how a trait is tested based on how many variations exist and the ecology. Once established, we can perform the model selection procedure which performs the ER, ARD, SYM (symmetrical), and Transient models. Once created, we can extract the AIC values from each model, place them into a table, and select the lowest AIC (which represents the best fit). This model will then be recapitulated in a separate script (models are very computationally expensive to run so we only need to extract the one we will use) and used to reconstruct ancestral states on the phylogeny.
***
## References
Authors: Guerin Brown, Andrew Forbes, PhD, and Miles Zhang, PhD    
Laboratories: Forbes Lab (University of Iowa) 

**Citations to Literature and Packages:** 

**Literature**
 
* **Phylogenetic Comparative Methods in R**: Revell, L. J. (2022). "Phylogenetic comparative methods in R." *Princeton University Press*. 
* **PACo: A Novel Procrustes Application to Cophylogenetic Analysis**: Balbuena JA, Míguez-Lozano R, Blasco-Costa I (2013) "PACo: A Novel Procrustes Application to Cophylogenetic Analysis." *PLOS ONE* 8(4): e61048. https://doi.org/10.1371/journal.pone.0061048
Hutchinson, M. C., Cagua, E. F., Balbuena, J. A., Stouffer, D. B., & Poisot, T. (2017). paco: Implementing Procrustean Approach to Cophylogeny in R. Methods in Ecology and Evolution, 8(8), 932–940. https://doi.org/10.1111/2041-210X.12736
* **A statistical test for host-parasite coevolution**: Legendre, P., Desdevises, Y., & Bazin, E. (2002). A statistical test for host-parasite coevolution. Systematic Biology, 51(2), 217–234. https://doi.org/10.1080/10635150252899734

**Packages** 

* **Phytools**: Revell LJ (2012). "phytools: An R package for phylogenetic
  comparative biology (and other things)." *Methods in Ecology and Evolution*, 3, 217-223.
* **Geiger**: Harmon L, Weir J, Brock C, Glor R, Challenger W (2008). "GEIGER: investigating evolutionary radiations." *Bioinformatics*, 24, 129-131.
* **PACo**: Balbuena JA, Míguez-Lozano R, Blasco-Costa I (2013) "PACo: A Novel Procrustes Application to Cophylogenetic Analysis." *PLoS ONE* 8(4): e61048. https://doi.org/10.1371/journal.pone.0061048
* **lmtest**: Zeileis A, Hothorn T (2002). "Diagnostic Checking in Regression Relationships." *R News*, 2(3), 7-10. https://CRAN.R-project.org/doc/Rnews/.
* **corHMM**: Beaulieu, J. M., O’Meara, B. C., & Donoghue, M. J. (2013). Identifying Hidden Rate Changes in the Evolution of a Binary Morphological Character: The Evolution of Plant Habit in Campanulid Angiosperms. *Systematic Biology*, 62(5), 725–737. https://doi.org/10.1093/sysbio/syt034

