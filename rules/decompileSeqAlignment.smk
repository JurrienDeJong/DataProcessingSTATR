"""
This snakefile decompiles the data using sam- and bam tools.
"""

rule samtoolsView:
              input:
                  config["outDir"] + "Aligned/{sample}_mapping.sam"

              output:
                  config["outDir"] + "Decompiled/{sample}_mapping.bam"

              message: "Starting decompile process. First sam tools view:"

              benchmark:
                    "benchmarks/samTools/{sample}.view.benchmark.txt"

              log: "logs/Decompiled/{sample}_mapping.log"

              shell:
                  "samtools view -bS {input} > {output} 2> {log}"


rule samtoolsSort:
                input:
                    config["outDir"] + "Decompiled/{sample}_mapping.bam"

                output:
                    config["outDir"] + "SortedReads/{sample}_mapping.bam"

                message: "Start sorting the bam files:"

                benchmark:
                    "benchmarks/samTools/{sample}.sort.benchmark.txt"

                log: "logs/SortedReads/{sample}_mapping.log"

                shell:
                    "samtools sort -T SortedReads/{wildcards.sample} "
                    "-O bam {input} > {output} 2> {log}"


rule bedtools_BamToBed:
                    input:
                        config["outDir"] + "SortedReads/{sample}_mapping.bam"

                    output:
                        config["outDir"] + "Decompiled/{sample}.bed"

                    message: "Creation of bed files from bam files:"

                    benchmark:
                        "benchmarks/bedTools/{sample}.benchmark.txt"

                    log: "logs/bedtools/{sample}.log"

                    shell:
                        "bedtools bamtobed -i {input} > {output} 2> {log}"