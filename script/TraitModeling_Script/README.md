### This script subdirectory is meant to hold all functioning script for ancestral state reconstruction of Synergus.

#### List of Files:
- ...Dependecies: This script automatically downloads all packages used in this analysis. 
- ...purlScript: This script automatically extracts chunks of code from the .rmd file
- ... Script...R: This is the script file of extracted chunks after ...purlScript has been run
- ...Script...rmd: This is the R Markdown file where all analysis was initially written. It contains both code and annotations. 

##### Instructions on running scripts individually
- The following instructions are provided using commands for linux and ubuntu. If you are using a different language, please modify as needed.
- Please see that all files are executable using ls -l
- If not, use the following to provide executable access to yourself:
```
$ chmod +x 700 inqcophy_Traitmodeling_*
```
- To execute, please run:
```
$ ./inqcophy_Traitmodeling_file.name
```

#### If you are attempting to recreate particular parts of this analysis, please see the .rmd file for annotations. If you would like a version of the script to use as a template, please see below:

### The following code was created to allow for easy reproducibility. 
#### Instructions on use
- Identify a particular trait you wish to reproduce in the trait modeling .csv file in "~/data"
- Open this file in VI
- Use the substitution command (:%s/NAME/{insert trait name from .csv}
- Copy the section that best describes the data (i.e. is the data discrete or a polymorphic trait)
- Insert the copied section into R version 4.2.2 with the correct dependencies (see ~/script)
- Modify any "INSERT LABLES/INSERT COMBO LABELS/INSERT FORMAL NAME" with the appropriate information
- Run Script

### Discrete Trait Template

```{r NAME DISCRETE, fig.height=10, fig.width=20, fig.align='center'}
#svg("/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output/inqcophy_traitmodeling_NAME_guerbrown.svg", width = 20, height = 10)

NAME <- setNames(data$NAME, rownames(data))
levels(NAME) <- unique(data$NAME)
NAME.ER <- ace(NAME, S, model = "ER", type = "discrete")

NAMEcols <- c("red", "blue", "green", "black")
plot.phylo(S, type = "fan", cex = 2, align.tip.label = F, lwd = 3.5, label.offset = 0.1, use.edge.length = F, open.angle =  165)
NAME_DATA <- setNames(data$NAME, data$Synergus)
NAMExx <- strsplit(as.character(NAME_DATA), split = "+", fixed = T)
NAMEpp <- matrix(0, length(NAME_DATA), 3, dimnames = list(names(NAME_DATA), c(INSERT LABELS)))
for (i in 1:nrow(NAMEpp)) NAMEpp[i,NAMExx[[i]]]<-1/length(NAMExx[[i]])
par(fg = "transparent")
ape::tiplabels(pie = NAMEpp, piecol = NAMEcols, cex = 0.15)
par(fg = "black")
tiplabels(pie = to.matrix(NAME, sort(unique(NAME))),piecol = NAMEcols, cex = 0.15)
nodelabels( node = 1:S$Nnode+Ntip(S),
    pie = NAME.ER$lik.anc, piecol = NAMEcols, cex=0.25)
tiplabels(pie = to.matrix(NAME, sort(unique(NAME))), piecol = NAMEcols, cex = 0.15)
legend("left", c(INSERT LABELS), pch = 21, pt.bg = c("red", "blue", "green", "black"), pt.cex = 3, title = "INSERT FORMAL NAME", cex = 1.5)

#dev.off()
```

### Polymorphic Trait Template

```{r NAME POLYMORPHIC, fig.height=10, fig.width=20, fig.align='center'}
NAME <- setNames(data$NAME, rownames(data))
# Rename the levels of the variable 
levels(NAME) <- unique(data$NAME)
# Recapitulation of the best fit model
NAME.ER <- fitpolyMk(S, NAME, model = "ER")
#pull states off the fitted model object
NAMExx <- apply(NAME.ER$data,1,
            function(x,ss) ss[which(x==1)],
            ss=colnames(NAME.ER$data))
#corHMM does not like to work with + so let's replace those with /
NAMExx <- gsub("+","/", NAMExx, fixed=TRUE)
#build corHMM data frame
NAME.data <- data.frame(Genus_sp = names(NAMExx), NAME = NAMExx)
#Pull out model design matrix from the fitted object
NAME_rate.mat <- NAME.ER$index.matrix
NAME_rate.mat[NAME_rate.mat==0] <- NA
colnames(NAME_rate.mat) <- rownames(NAME_rate.mat) <- gsub("+","/", colnames(NAME_rate.mat), fixed=TRUE)
NAMEind <- order(colnames(NAME_rate.mat))
NAME_rate.mat <- NAME_rate.mat[NAMEind, NAMEind]
#Ancestral States
NAME_fit.marginal <- corHMM(S, NAME.data,
                     rate.mat = NAME_rate.mat,
                     node.states = "marginal",
                     rate.cat = 1, p = NAME.ER$rates,
                     root.p = NAME.ER$pi)
#Marginal states are stores in $states. Extract this and ensure the model is consistent
NAMEasr <- NAME_fit.marginal$states
colnames(NAMEasr) <- colnames(NAME_rate.mat)
colnames(NAMEasr) <- gsub("/","+", colnames(NAMEasr))

# Adding these to the figure

#svg("/home/guerbrown/github_local/biol-4386-course-project-guerbrown/output/inqcophy_traitmodeling_NAME_guerbrown.svg", width = 20, height = 10)

NAMEpp <- matrix(0, length(NAME), 3, dimnames = list(names(NAME), c("Asexual", "Sexual", "Asexual+Sexual")))
plot.phylo(S, type = "fan", cex = 1.5, align.tip.label = F, lwd = 2, label.offset = 0.05, use.edge.length = F, open.angle =  163, node.depth = 100)
NAMEX <- strsplit(setNames(as.character(NAME_rate.mat), names(NAME_rate.mat)),"+", fixed=TRUE)
pies <- matrix(0, Ntip(S),2,
	dimnames=list(S$tip.label,
	c("Asexual","Sexual")))
for(i in 1:Ntip(S)) 
	pies[S$tip.label[i],
		NAMEX[[S$tip.label[i]]]]<-
		rep(1/length(NAMEX[[S$tip.label[i]]]),
		length(NAMEX[[S$tip.label[i]]]))
NAMEcols <- setNames(c("firebrick1", "dodgerblue1"),
	c("Asexual","Sexual"))
par(fg="white")
NAME <- setNames(data$NAME, data$Synergus)
NAMExx <- strsplit(as.character(NAME), split = "+", fixed = T)
NAMEpp <- matrix(0, length(NAME), 3, dimnames = list(names(NAME), c("Asexual", "Sexual", "Asexual+Sexual")))
for (i in 1:nrow(NAMEpp)) NAMEpp[i,NAMExx[[i]]]<-1/length(NAMExx[[i]])
tiplabels(pie = NAMEpp, piecol = NAMEcols, cex=0.3)
par(fg="white")
piecol <- NAMEcols
for(i in 1:ncol(NAMEasr)){
	NAMEnn <- strsplit(colnames(NAMEasr)[i],"+", fixed=TRUE)[[1]]
	if(length(NAMEnn)==1) piecol[i] <- NAMEcols[NAMEnn]
	else if(length(NAMEnn)==2) piecol[i] <- colorRampPalette(NAMEcols[NAMEnn])(3)[2]
	else piecol[i]<-"black"
}
names(piecol)<-colnames(NAMEasr)
par(fg="white")
nodelabels(pie = NAMEasr, piecol = NAMEcols,cex=0.40)
par(fg="black")
legend("left", c("Asexual", "Sexual"), pch = 21, pt.bg = c("firebrick1", "dodgerblue1"), pt.cex = 3, title = "Gall Former Generation", cex = 1.5)

#dev.off()
```
