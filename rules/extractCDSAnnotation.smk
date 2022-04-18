
"""
This snakefile converts the reference genome to a gff3 file and extract the CDS annotation along the way.
"""

rule parse_genome_annotation:
                      input:
                          config["workdir"] + "data/" + config["ref_genome"] + config["extensions"]["anno"]

                      output:
                          config["outDir"] + "refDb/" + config["ref_genome"] + config["extensions"]["created_anno"]

                      threads: int(config["threads"])

                      message: "Parse genome anno file:"

                      log: "logs/referenceDB/" + config["ref_genome"] + "_CDS.log"

                      script:
                          config["workdir"] + "scripts/python/ParseGenomeAnnotation.py"