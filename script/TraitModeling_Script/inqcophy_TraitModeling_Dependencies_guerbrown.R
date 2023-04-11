#Use this script to download any packages used in the analysis

install.packages("geiger")
install.packages("paco")
install.packages("ape")
install.packages("vegan")
install.packages("phytools")
install.packages("plotrix")
install.packages("svglite")
install.packages("knitr")
<<<<<<< HEAD
=======
#If corHMM will not install run this:
#sudo apt-get install libgmp-dev libmpfr-dev
#install.packages("gmp")
#install.packages("Rmpfr")
#install.packages("corHMM")
>>>>>>> 44842d11294899603cc60ca9207d336373839d6e
install.packages("corHMM")

# Note: corHMM struggles to install on ubuntu. First, amke sure cmake is installed. If you still have troubles after this run the following code:
#sudo apt-get install libgmp-dev libmpfr-dev
#R
#install.packages("gmp")
#install.packages("Rmpfr")
#install.packages("corHMM")
# If this still fails, try: 
#install.packages("path/to/package.tar.gz", type="source")
