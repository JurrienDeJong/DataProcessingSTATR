'''
This is the 'main' script which runs and includes all other necessary rules in order to
create a .gff profile for all given fastq.gz samples.
@Author: Jurrien de Jong
'''

configfile: "config/config.yaml"

rule all:
    input:
        expand(config["workdir"] + "out/metaAnalysis/{sample}_profile.gff", sample = config["samples"])


include: "rules/qualityTrimming.smk"
include: "rules/readMapping.smk"
include: "rules/decompileSeqAlignment.smk"
include: "rules/experimentValidation.smk"
include: "rules/extractCDSAnnotation.smk"
include: "rules/generateProfile.smk"