"""
This snakfile creates coverage files using bedtools coverage which are used to create and format the DeSeq file.
"""

SAMPLES = config["samples"]

rule bedtools_cov:
              input:
                  ref = config["outDir"] + "refDb/" + config["ref_genome"] + "_CDS.gff",
                  bed = config["outDir"] + "Decompiled/{sample}.bed"

              output:
                  config["outDir"] + "DifferentialExpression/{sample}.cov"

              threads: int(config["threads"])

              message: "Started with differential expression"

              benchmark:
                    "benchmarks/bedTools/{sample}.cov.benchmark.txt"

              log: "logs/DifferentialExpression/{sample}.log"

              shell:
                  "bedtools coverage -a {input.ref} -b {input.bed} -s > {output} 2> {log}"


rule format_DESeq:
              input:
                  expand(config["outDir"] + "DifferentialExpression/{sample}.cov", sample=SAMPLES)

              output:
                  config["outDir"] + "DifferentialExpression/DESeqInput.txt"

              threads: int(config["threads"])

              message: "Started with formatting differential expression file"

              log: "logs/DifferentialExpression/DESeqInput.log"

              script:
                  config["workdir"] + "scripts/python/FormatDeSeqInput.py"