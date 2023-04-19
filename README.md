# Evolution of a genus of gall wasp kleptoparasites
### Guerin E. Brown<sup>1</sup>, Andrew A. Forbes<sup>1</sup>, & Y. Miles Zhang<sup>2</sup>

<sup>1</sup>The University of Iowa

<sup>2</sup>The University of Edinburgh
***

### This work is for BIOL 4386 (Introduction to Scientific Computing) during the Spring 2023 semester. This repository aims to understand evolution of Synergus kleptoparasites with respect to ecology and comparative phylogenetics. All analysis was performed under R 4.2.2 and is adapted from both [Balbuena et al., 2013](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0061048) and [Revell & Harmon (2022)](https://press.princeton.edu/books/paperback/9780691219035/phylogenetic-comparative-methods-in-r).

* * *

## Abstract

Kleptoparasites do not directly parasitize their hosts but instead steal food and resources, reducing host fitness. Like direct parasites, kleptoparasites can be highly dependent on their hosts such that their evolutionary histories may be linked. Here, we study the evolution of a kleptoparasitic wasp genus, *Synergus* (Hymenoptera: Cynipidae: Synergini), in relation to their hosts, oak gall wasps (Hymenoptera: Cynipidae: Cynipini). Ovipositing oak gall wasps induce the formation of galls on oaks (Fagaceae) that provide food and shelter to one or more developing gall wasps. Galls induced by different gall wasp species are diverse in size, shape, color, and location on the host tree, and tend to be specific to just one or a few oak tree species. *Synergus*, and other kleptoparasites, exploit galls by ovipositing into the developing gall and inducing the development of a secondary gall chamber. *Synergus* larva feed on the gall tissue, sometimes reducing food available to the oak gall wasp larva to the extent that the host dies. We ask how the ecology of gall wasps has affected the diversification of *Synergus*. We compare the topologies of *Synergus* and gall wasp phylogenetic trees and detect a significant signal of cophylogeny, or congruence of the evolutionary relationships, that appears limited to only a few interactions. We use traits of oak galls to describe the ecological niche for each *Synergus* species and reconstruct ecological traits of ancestral nodes and find that *Synergus* kleptoparasites are evolving both under cospeciation and host swapping scenarios.

* * *

## Introduction

Several insect orders have evolved an ability to induce galls - non-usual growths of plant tissue that provide nutrition and defenses to the progeny of the gall-forming insect. Despite the defenses provided by galls, most gall-forming insect species nevertheless are attacked by specialized parasites that evade those defenses and kill the young insect. A galling insect and its parasites are thus partnered in an ecological and evolutionary dance: changes to a gall’s defenses that result in enhanced evasion of parasites may improve gallformer fitness, while a parasite’s fitness might improve via changes in the ways it overcomes those defenses. There are a variety of possible long-term outcomes of such interactions. This includes scenarios such as cospeciation, where both partners coevolve and ultimately codiversify in concert with one another, or host swapping, wherein parasites evolve adaptations to attack hosts with different traits than those parasitized by ancestral taxa. Gallformers might also escape their ancestral parasites by undergoing dramatic evolutionary changes in gall structure, location, or phenology.

However, considering only the evolutionary interactions between single pairs of gallformer and parasite species wildly simplifies the typical gall’s ecological landscape. Most gall-forming insects are attacked by not one but a diverse community of parasitic species. Those same gall-formers also often live in sympatry with myriad other gall-forming insect species, each associated with their own parasite community. Thus, as a gall-former’s defenses evolve, it might partially or entirely evade attack from one parasite but become more vulnerable to attack by another parasitic species already exapted to the new defenses: perhaps a congener of the ancestral parasite, perhaps a parasite from another genus entirely. Similarly, a parasite’s trait evolution in response to changes in its host gall might also make that parasite better able to attack new gall types. If parasite host shifts and host range expansions are sufficiently common, host and parasite phylogenies may not be tightly linked, with clades of parasites being united more by shared gall traits than by host phylogeny. Further, different genera of parasites interacting with the same communities of gallformers might show similar histories, complementary histories, or some mixture of the two.

Though there has long been intense interest in the evolution and ecology of galling insects and their myriad associated natural enemies, there has been scant cophylogenetic research to date, and we find no studies that consider the cophylogeny of galling insects alongside multiple different parasitic clades. One of the still-rare studies of gallformer-parasite cophylogeny involves fig wasps in genus *Platyneura*, which induce galls inside Ficus flowers, and their parasitoids in genus *Apocrypta*. In this system, the topologies of the *Apocrypta* and *Platyneura* phylogenies are not significantly more congruent than would be expected by chance, suggesting the two clades have neither co-speciated nor tracked one another (Silvieus *et al.* 2008). In two other insect gall systems, phylogeographic structure has been compared between host and parasites. Two parasitoid wasp species that attack the rose galler *Diplolepis rosae* in Europe do not appear to have tracked their host’s recent evolutionary history (Kohnen *et al.* 2012). In contrast, *Megastigmus* parasitoids of Palearctic oak gall wasps apparently share divergence timing and phylogeographic histories that parallel those of their hosts (Nicholls *et al.* 2010). These contrasting patterns of genetic structure and the overall dearth of existing studies both underscore the complexity of these systems.

Oak gall wasps (Hymenoptera: Cynipidae) that induce galls on oak trees present an excellent system for studying the intertwined evolutionary histories of gallformers and their natural enemies. In the Nearctic, >700 species of oak gall wasp induce galls on oak species. Most oak gall wasp species have a sexual and an asexual generation, each of which induces a gall of a specific type on a specific organ of a specific oak species. The galls themselves, already variable in their tree host and location on those trees, also vary greatly in morphology and other potential defensive traits. Some galls are smooth, others may have a light pubescence, long hair, or even long spines. Some produce nectar, shown to both trap parasites and attract beneficial predators. Some have larval cells protected by bark, while for others the cells are suspended by fibers or are free-rolling in hollow chambers, which may make it more challenging for parasites to oviposit. Phenology, including both the time of year that the gall is present and the incubation time of the larval gall wasp, also varies greatly and may restrict attack by certain parasites. Non-visible traits such as titers of chemical defenses, may vary too, but such variation has only rarely been compared across gall types. A single oak tree species can host to many co-occurring galls induced by different wasp species and oak species in many parts of the Nearctic are broadly sympatric, such that many “types” of different oak galls often occupy a single landscape.

Community diversity studies documenting all of the natural enemies from any single species of Nearctic oak gall wasp are rare, but when they have been performed it is typical that ten or more different species of parasite, kleptoparasite, and/or hyperparasite are recorded from a gall type (e.g., Joseph *et al.* 2011, Bird *et al.* 2013; Forbes *et al.* 2016, Weinersmith *et al.* 2020). Among the known Nearctic oak gall associates, at least 11 insect genera (*Allohorgas, Brasema, Ceroptres, Euceroptres, Euderus, Eupelmus, Eurytoma, Ormyrus, Sycophila, Synergus, Torymus*) each have several different species associated with one or more galls (Ward *et al.* 2022b), suggesting each genus has a long-standing evolutionary relationship with oak galls. These 11 genera present opportunities to test whether galler-parasite evolutionary histories are more often defined by cospeciation or by shifting patterns of host-parasite relationships, as well as whether different natural enemies share similar histories.
Here, we attempt to disentangle the evolutionary histories of three natural enemy genera that together comprise a single guild of oak gall associates: the kleptoparasitic cynipoid wasps. Often described as inquilines, wasps in the genera *Synergus* (Cynipidae) feed primarily on the tissue of their host gall and not on the gallformer. Their presence sometimes results in the death of the gall wasp and sometimes does not, but in either case their co-option of the gall wasp’s resource makes them more parasitic than strictly inquilinous. *Synergus* wasps form secondary chambers in the host gall. This genus is one of the most common kleptoparasites associated with Nearctic oak gall wasps and thus studying how the genus evolved alongside their gall wasp hosts allows for a deeper understanding of the evolutionary concert between hosts and parasites.

We have previously reared wasps of this genus from a phylogenetically diverse set of Nearctic oak galls (Ward *et al.* 2022b). Many have been previously separated into putative species using mitochondrial sequence variation, morphology, and ecology (Ward *et al.* 2020), but no multi-gene phylogeny of *Syergus* exists. We here infer phylogenies and delimit putative species for samples across the genus, and then use host gall ecology and the existing phylogeny of Nearctic oak gall waps (Ward *et al.* 2020) to as two overarching questions. First, is there a co-phylogenetic signal between *Synergus* kleptoparasites and their gallformer hosts, and, if so, does this appear to reflect cospeciation or have some other potential cause? Second, has the use of galls with different traits evolved over time and have gall traits potentially affected kleptoparasite evolution?

* * *

## Materials and Methods

**Procrustean Approach to Cophylogeny (PACo)**
The first part of this analysis uses a "procrustean approach to cophylogeny" (PACo; Balbuena *et al.*, 2013; Hutchinson *et al.*, 2017). This analysis takes the topology of two phylogenetic trees, usually a host and a parasite, and compares the shapes in a graphical plane. This involves shifting coordinates, or values, that define the shapes and superimposing them onto one another (also known as procrustean superimposition). So, it does not matter if the values that graphically define one shape are smaller than another, each is shifted in proportionally so that both shapes can be compared in the same virtual space. Once superimposed, a value of the similarity can be extracted. In PACo, this is the value of cophylogeny that describes whether there is congruence between the shape of two phylogenetic trees. This can be further assessed by completing a ParaFit analysis which provides a value of coevolution for each association (Legendre *et al.*, 2002).

For this analysis, we utilize phylogenetic trees created from concatenated ultra-conserved elements (UCE) and cytochrome oxidase subunit 1 (CO1) data of *Synergus* and Cynipini along with multiple matrices of associations and character traits. The statistical computation was completed entirely in R version 4.2.2 using the packages "PACo", "geiger", "phytools", "ape", "corHMM", and "lmtest".

To perform PACo analysis of cophylogeny, we will first begin by accessing the data in R. Next, we plot the phylogenies for *Synergus* and Cynipini in a cophyloplot and use data from an association matrix to draw lines of association. Lastly, we will use the quantitative values of the branches from both phylogenies to create a matrix of patristic distances or sums of the branch lengths that link nodes.

Once all three of these matrices have been created, we can complete the PACo analysis of cophylogeny set to 10,000 permutations. Since we are forcing a shape change between two objects, one object may be shifting in a negative direction which will result in a negative eigenvalue, or scalar factor of transformation. Negative eigenvalues cannot be read when performing the ParaFit analysis of coevolution as they do not represent 'real space' so must correct them. To do this, we completed a manual correction using square roots, the "Cailliez" correction, and the "Lingoes" correction (Hutchinson *et al.*, 2017). We chose the most conservative correction from these three to interpret. We extracted values of the residuals from the analysis and plotted them on a bar graph while drawing the line of best fit as a flat linear value going through the middle of the plot.

**Ancestral State Reconstructions**
The second part of this analysis attempts to visualize how physical traits or characteristics of oak gall wasps might constrain or affect evolution of *Synergus* kleptoparasites. This involves associating a particular trait of an oak gall wasp to its corresponding *Synergus* taxa. For example, we can associate the location an oak gall wasp forms galls on an oak tree (i.e., leaf, stem, bud, or fruit) to the corresponding *Synergus* that parasitizes that oak gall wasp. After completing this for each *Synergus* species, we can perform tests that attempt to simulate how these traits may have arisen at terminal nodes of the phylogeny. These tests utilize models to describe how traits evolve. For example, the "equal rates" (ER) model simulates evolution of the traits using the assumption that the likelihood of changing from one trait to another is uniform for all variations of that trait. Other models exist such as the "all-rates different" (ARD) model where each variation of a trait has a unique probability of being gained or lost evolutionarily. Each model has a corresponding AIC (Akaike Information Criterion) value that determines how close of a fit it is to the expected result at the terminal nodes, or how likely it is to be accurate in predicting them. We performed multiple tests for each trait and chose the model with the lowest AIC value to ensure statistical accuracy. This resulted in the ER models being the most highly supported for ancestral state reconstruction for each trait tested. We completed this for traits such as gall size, presence of spines on the gall, texture, hairiness, nectar production, presence of fibers inside, location of the gall on the oak, phenology, and oak species.

* * *

## Results

![combined_image.pnd](https://github.com/Intro-Sci-Comp-UIowa/biol-4386-course-project-guerbrown/blob/main/final_images/combined_image.png)
Figure 1. A) Tanglegram showing associations between *Synergus* and Cynipini. The red lines overlap regions that are marked as significant (*p* < 0.01) by a ParaFit analysis. B) Bar plot of residuals for each association from the PACo analysis. The dotted horizontal line depicts the median squared residual. Error bars are shown with each association. Associations that were significant in ParaFit are marked with asterisks. C-F) Ancestral state reconstructions of three different ecological traits of Cynipini mapped to the *Synergus* phylogeny.

**PACo and Cophylogeny:**
PACo analysis of Synergus and their gall wasp phylogenies rejected the hypothesis that associations between trees are random (10K permutation, m<sup>2</sup><sub>xy</sub> = 0.0259, *p* < 0.00001). However, bar plots of squared residuals from PACo (Fig. 1B) show associations that were significant from the ParaFit analysis (marked with an asterisk) which indicate host-parasite coevolution occurring primarily in associations of *Synergus* kleptoparasites and gall wasps in the genus *Philonix*. These associations are marked with a red line in Fig. 1A. No other associations were marked as significant in the ParaFit analysis which suggests that the association between *Synergus* and *Philonix* are biasing the analysis in one direction. We then performed the ParaFit analysis using three different corrections for negative eigenvalues produced from the Procrustes superimposition: Cailliez, Lingoes, and a manual square-root correction (Cailliez, 1983; Lingoes, 1971; Hutchinson et al., 2017). From these, we chose the most conservative correction to interpret. This generated a ParaFit statistic equal to 0.0254 with a permutational *p* = 0.458 at 10k permutations. These results indicate that the similarity of diversification between Synergus and Cynipidae cannot be attributed to random chance and suggests congruence with a coevolutionary history.

**Discrete Trait Analysis and Ancestral State Reconstruction:**
The results from our PACo and ParaFit analysis suggest that many of the associations between kleptoparasites and their hosts cannot be attributed cophylogentic congruence nor do they fit the statistical models of coevolution. To better understand this, we chose to model traits of kleptoparasite hosts to the *Synergus* phylogeny. This will allow visualization of *Synergus* evolving to parasitize hosts either under expectations of cospeciation or host switching. We modeled twelve traits of Cynipini to the *Synergus* phylogeny and observed a combination of cospeciation and host swapping scenarios. Occasionally, both were present in the same phylogeny (Fig. 1D). However, the primary result from these reconstructions is best fit by a host swapping scenario (Figs. 1C & 1D). In these reconstructions, we are defining cospeciation events as tightly conjoined evolutionary events that manifest as individual clades in the phylogeny. For example, Fig. 1D shows a reconstruction of oak section on the *Synergus* phylogeny. On the leftmost side of the tree, we can visualize a complete clade forming with high support for the likelihood that the most recent common ancestor having the trait present at the terminal nodes of *S. coniferae*, *Synergus nr. lignicola*, and *S. lignicola*. Likewise, this phylogenetic tree and those seen in Figs.1C & 1E also show other scenarios separate from our defined coevolution. These patterns, wherein the ability to parasitize galls with a particular trait evolves at multiple points in the phylogeny, we refer to as host swapping. These patterns can be described under the host swapping hypothesis wherein *Synergus* kleptoparasites evolve towards traits suddenly, at least in the scaling of geologic time.

* * *

## Discussion

Our results provide insight that some associations between hosts and parasites fit the conceptual idea of close evolutionary choreography. However, this analysis only attempts to study one particular genus of kleptoparasites and ignores additional interactions in separate systems. Our findings that some associations can be statistically represented as coevolution raises questions on how these computational procedures can be applied to additional genera of gall wasp kleptoparasites or even additional systems with close host-parasite associations. Moreover, our findings that *Synergus* kleptoparasites do not directly fit either model of trait evolution we can conclude that some traits appear more accurate to one description. This may suggest that traits are quickly being evolved by positive selection since oak gall are so regularly invaded by a diverse community of insects other than this one genus of kleptoparasites.

To fully develop a complete understanding of how kleptoparasites evolve in relation to their hosts, we intend to extend this analysis to other genera of kleptoparasites that are closely associated with oak galls. These include the genera *Ceroptres* and *Euceroptres*. Our laboratory has reared a considerable amount of both genera from oak galls. UCE data is already available for *Ceroptres* kleptoparasites but has not been completed for *Euceroptres* or other genera of kleptoparasites. Additionally, our analysis only begins to formulate a complete picture of how ecological space may alter diversification of kleptoparasites. To understand how these organisms may interact with each other, on of our following steps will be to characterize ecological traits and model them as principle component analyses. Theoretically, this should allow us to determine whether particular genera are saturating a specific ecological trait of galls and may explain why there is not widespread diversification towards particular traits in the case of *Synergus*.

* * *

## References

**Literature**

- **Phylogenetic Comparative Methods in R**: Revell, L. J. (2022). "Phylogenetic comparative methods in R." *Princeton University Press*.
- **PACo: A Novel Procrustes Application to Cophylogenetic Analysis**: Balbuena JA, Míguez-Lozano R, Blasco-Costa I (2013) "PACo: A Novel Procrustes Application to Cophylogenetic Analysis." *PLOS ONE* 8(4): e61048. https://doi.org/10.1371/journal.pone.0061048
- **paco: Implementing Procrustean Approach to Cophylogeny in R. Methods in Ecology and Evolution**: Hutchinson, M. C., Cagua, E. F., Balbuena, J. A., Stouffer, D. B., & Poisot, T. (2017). paco: Implementing Procrustean Approach to Cophylogeny in R. Methods in Ecology and Evolution, 8(8), 932–940. https://doi.org/10.1111/2041-210X.12736
- **A statistical test for host-parasite coevolution**: Legendre, P., Desdevises, Y., & Bazin, E. (2002). A statistical test for host-parasite coevolution. Systematic Biology, 51(2), 217–234. https://doi.org/10.1080/10635150252899734
-**Cophylogeny of Figs, Pollinators, Gallers, and Parasitoids**: Silvieus, S., Clement, W., Weiblen, G. (2008) Cophylogeny of Figs, Pollinators, Gallers, and Parasitoids. Specialization, Speciation, and Radiation: The Evolutionary Biology of Herbivorous Insects, 225-239. https://doi.org/10.1525/california/9780520251328.003.0017
- **No Concordant Phylogeographies of the Rose Gall Wasp Diplolepis rosae (Hymenoptera, Cynipidae) and Two Associated Parasitoids across Europe**: Kohnen, A., Brandl, R. (2012) No Concordant Phylogeographies of the Rose Gall Wasp Diplolepis rosae (Hymenoptera, Cynipidae) and Two Associated Parasitoids across Europe. PLOS ONE. https://doi.org/10.1371/journal.pone.0047156
- **The parasitoid community of Andricus quercuscalifornicus and its association with gall size, phenology, and location. Biodiversity and Conservation**: Joseph, M. B., Gentles, M., & Pearse, I. S. (2011). The parasitoid community of Andricus quercuscalifornicus and its association with gall size, phenology, and location. Biodiversity and Conservation, 20(1), 203–216. https://doi.org/10.1007/s10531-010-9956-0
- **Speciation in Nearctic oak gall wasps is frequently correlated with changes in host plant, host organ, or both**: Ward, A. K. G., Bagley, R. K., Egan, S. P., Hood, G. R., Ott, J. R., Prior, K. M., Sheikh, S. I., Weinersmith, K. L., Zhang, L., Zhang, Y. M., & Forbes, A. A. (2022). Speciation in Nearctic oak gall wasps is frequently correlated with changes in host plant, host organ, or both. Evolution, 76(8), 1849–1867. https://doi.org/10.1111/evo.14562
- **Diversity, Host Ranges, and Potential Drivers of Speciation Among the Inquiline Enemies of Oak Gall Wasps**: Ward, A. K. G., Sheikh, S. I., & Forbes, A. A. (2020). Diversity, Host Ranges, and Potential Drivers of Speciation Among the Inquiline Enemies of Oak Gall Wasps (Hymenoptera: Cynipidae). Insect Systematics and Diversity, 4(6), 3. https://doi.org/10.1093/isd/ixaa017
- **Invertebrate Community Associated with the Asexual Generation of Bassettia pallida Ashmead (Hymenoptera: Cynipidae)**: Weinersmith, K. L., Forbes, A. A., Ward, A. K., Brandão-Dias, P. F., Zhang, Y. M., & Egan, S. P. (2020). Invertebrate Community Associated with the Asexual Generation of Bassettia pallida Ashmead (Hymenoptera: Cynipidae). BioRxiv, 2020–01.
- **Community impacts of anthropogenic disturbance: natural enemies exploit multiple routes in pursuit of invading herbivore hosts**: Nicholls, J.A., Fuentes-Utrilla, P., Hayward, A. et al. Community impacts of anthropogenic disturbance: natural enemies exploit multiple routes in pursuit of invading herbivore hosts. BMC Evol Biol 10, 322 (2010). https://doi.org/10.1186/1471-2148-10-322

**Packages**

- **Phytools**: Revell LJ (2012). "phytools: An R package for phylogenetic
    comparative biology (and other things)." *Methods in Ecology and Evolution*, 3, 217-223.
- **Geiger**: Harmon L, Weir J, Brock C, Glor R, Challenger W (2008). "GEIGER: investigating evolutionary radiations." *Bioinformatics*, 24, 129-131.
- **PACo**: Balbuena JA, Míguez-Lozano R, Blasco-Costa I (2013) "PACo: A Novel Procrustes Application to Cophylogenetic Analysis." *PLoS ONE* 8(4): e61048. https://doi.org/10.1371/journal.pone.0061048
- **lmtest**: Zeileis A, Hothorn T (2002). "Diagnostic Checking in Regression Relationships." *R News*, 2(3), 7-10. https://CRAN.R-project.org/doc/Rnews/.
- **corHMM**: Beaulieu, J. M., O’Meara, B. C., & Donoghue, M. J. (2013). Identifying Hidden Rate Changes in the Evolution of a Binary Morphological Character: The Evolution of Plant Habit in Campanulid Angiosperms. *Systematic Biology*, 62(5), 725–737. https://doi.org/10.1093/sysbio/syt034
