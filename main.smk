'''
This is the 'main' script which runs and includes all other necessary rules in order to create:
    1. A .gff profile for all given fastq.gz samples.
    2. A DAG file of the entire pipeline
    3. A PCA plot.
    4. A Dendrogram and heatmap.

@Author: Jurrien de Jong
@Date: 14-4-2022
'''


configfile: "config/config.yaml"


rule all:
      input:
          expand(config["workdir"] + config["outDir"] + "metaAnalysis/{sample}_profile.gff", sample = config["samples"]),
          "images/ruleGraph.pdf",
          "images/DAG.pdf",
          "images/PCA.pdf",
          "images/DendrogramAndHeatmap.pdf"

include: "rules/createDAG.smk"

include: "rules/trimming.smk"
include: "rules/readMapping.smk"
include: "rules/decompileSeqAlignment.smk"
include: "rules/extractCDSAnnotation.smk"
include: "rules/DifferentialExpression.smk"
include: "rules/VisualizeUsingR.smk"
include: "rules/generateProfile.smk"
include: "rules/experimentValidation.smk"