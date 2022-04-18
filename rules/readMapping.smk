"""
This snakefile builds a reference database and mapping reads with Bowtie2
"""

rule bowtie_database:
            input:
                config["workdir"] + "data/" + config["ref_genome"] + config["extensions"]["ref"]

            params:
                base= config["workdir"] + config["outDir"] + "reference"

            output:
                touch(config["outDir"] +  "flag_files/index.done")

            threads: int(config["threads"])

            message: "Building reference database"

            log:
              "logs/bowtie/index.log"

            shell:
                "bowtie2-build -f {input} {params.base} 2> {log}"



rule bowtie_mapping:
              input:
                  trim = config["outDir"] +  "TrimmedReads/{sample}_trimmed.fastq.gz",
                  check = config["outDir"] + "flag_files/index.done"

              params:
                    base= config["workdir"] + config["outDir"] + "reference",

              output:
                    config["outDir"] + "Aligned/{sample}_mapping.sam"

              threads: int(config["threads"])

              benchmark:
                    "benchmarks/bowtie/{sample}.mapping.benchmark.txt"

              message: "Start Bowtie read Mapping:"

              log: "logs/bowtie/{sample}_mapping.log"

              shell:
                  "bowtie2 -q -U {input.trim} -x {params.base} -S {output} --local 2> {log}"