'''
Main script to be executed.
Includes all necessary Snakefiles needed
to execute the workflow.
'''


rule all:
    input:
        expand("out/metaAnalysis/{sample}_profile.gff", sample = config["samples"])


configfile: "config/config.yaml"
include: "rules/qualityTrimming.smk"
include: "rules/readMapping.smk"
include: "rules/decompileSeqAlignment.smk"
include: "rules/extractCDSAnnotation.smk"
include: "rules/experimentValidation.smk"
include: "rules/generateProfile.smk"