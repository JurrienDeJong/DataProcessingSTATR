"""
This snakfile uses the check periodicity script to validate the data.
"""


rule checkPeriodicity:
    input:
        gffAnno = config["outDir"] + "refDb/" + config["ref_genome"] + config["extensions"]["created_anno"],
        bed = config["outDir"] + "Decompiled/{sample}.bed",
        script = "scripts/python/CheckPeriodicity.py"
    output:
        config["outDir"] + "metaAnalysis/MetaPositionalDensity_{sample}.txt"
    benchmark:
        "benchmarks/metaAnalysis/{sample}.check_periodicity.benchmark.txt"
    message:
        'Using {input.script} to generate {output}'
    shell:
        "python {input.script} -i {input.bed} -a {input.gffAnno} -o {output}"