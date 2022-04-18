------------------------------------------------------------------------

# Summary

This pipeline creates three visualizations ( a PCA plot, a dendogram, and a heatmap ) and a genome-wide ribosome density file
for each sample provided. The pipeline consists of several steps to 'tweek' the data in order to come to the final product.
Please view the pipeline image below and/or the explanation for the rules.

------------------------------------------------------------------------

Here the link to the article:
[article](https://link.springer.com/article/10.1007/s12275-020-9536-2).

------------------------------------------------------------------------

Pipeline rule graph: ![](images/ruleGraph.pdf) 
( Note this is a rule graph representation! )


Pipeline DAG: ![](images/DAG.pdf) 
The actual DAG

------------------------------------------------------------------------

# Rule Contents

- Rule Main.smk

'Main' rule including all other rules and contains a rule all which fetches the profiles and images.

- Rule VisualizeUsingR.smk

This snakefile runs the R script RunDeSeq.R which in return returns plots, like the dendogram and PCA plot.

- Rule trimming.smk

This snakefile uses trimmomatic to filter low quality reads and adapter sequences

- Rule readMapping.smk

This snakefile uses various tools of Bowtie. It first creates a reference database which is then used for mapping.

- Rule generateProfile.smk

This snakefile creates a profile per sample using a python script.

- Rule extractCDSAnnotation.smk

This snakefile takes in a .gff file and collects the CDS annotations for further use in the pipeline.

- Rule experimentValidation.smk

This snakefile checks if the data is valid or not by using a given python script.

- Rule DifferentialExpression.smk

This snakefile creates a format for DeSeq for later use and creates coverage files from the bed files.

- Rule decompileSeqAlignment.smk

This snakefile contains rules which convert sam to bam files, sort bam files and convert bam to bed files.

- Rule createDAG.smk

Creates a DAG and a rule Graph representation of the pipeline.

# Setting up process

## Collect files

Required files:

There are files available in the repo link although you can also get
some for yourself. Here are the requirements;

-   Download and locate the adapter sequence in trimmomatic/adapters/
    directory. Otherwise it won't work! (RiboSeq_adapter.fa)

-   Download sequence files (.fastq.gz format).  
    Locate the desired input files in the data folder.  

-   Find the genome annotation file and download the file in the
    referenceDB/ directory. (NC_000913.3.gff3) Search for genome annotation file at [NCBI](https://www.ncbi.nlm.nih.gov/nuccore)

-   Download and locate the reference genome sequence file in
    referenceDB/ directory. (NC000913.3.fa) 
ref genomes can be found on: [NCBI](https://www.ncbi.nlm.nih.gov/nuccore)

-   Lastly a design sheet is needed, this is a file containing all the sample information.
    (designSheet.txt)

------------------------------------------------------------------------

## Installing snakemake

Required software:

For linux:

R v4.0.4  
Python v3.9.2

Creating a virtual enviroment: ( required! )

`python3 -m venv {path/to/new/virtual/environment} #create a virtualenv`
 
`source {path/to/new/virtual/environment}/bin/activate #activate the virtualenv`  
`pip3 install snakemake {name}`

------------------------------------------------------------------------

Trimmomatic tool comes from a jar file so needs to be installed manually;

[trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) v0.39  
Trimmomatic must be placed in trimmomatic/ folder and unzip the binary
file.  
The pipeline needs to know the path to the trimmomatic-0.39.jar file.


bowtie2 v2.4.2 ( Bowtie"0" also works but 2 is recommended )

#### create and go to install directory

`cd $HOME/tools/bowtie2/`

#### download Ubuntu/Linux version

`wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.4.2/bowtie2-2.4.2-sra-linux-x86_64.zip/download`

#### decompress

`unzip download`

#### add location to system PATH

`export PATH=$HOME/tools/bowtie2/bowtie2-2.4.2-sra-linux-x86_64:$PATH`


samtools v1.11

#### create and go to install directory

`cd $HOME/tools/samtools/`

#### download Ubuntu/Linux version

`wget https://sourceforge.net/projects/samtools/files/samtools/1.11/samtools-1.11.tar.bz2/download`

#### decompress

`unzip download`

#### add location to system PATH

`export PATH=$PATH:/directory/samtools-0.1.11`


[bedtools](https://bedtools.readthedocs.io/en/latest/content/installation.html)
v2.30.0  
Choose the desired installation.


---------------------------

# Credits

[Snakemake](https://snakemake.readthedocs.io/en/stable/index.html)
[Article](https://link.springer.com/article/10.1007/s12275-020-9536-2)  
Lecturer; Fenna Feenstra  

# Contact

e-mail: <ju.de.jong@st.hanze.nl>