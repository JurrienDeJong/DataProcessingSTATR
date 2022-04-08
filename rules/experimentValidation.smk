# rule all:
#     input:
#         "out/CDSAnno/CDSAnno.gff3"

rule checkPeriodicity:
    input:
        gffAnno = "out/CDSAnno/CDSAnno.gff",
        bed = "out/decompiled/{sample}.bed",
        script = "scripts/CheckPeriodicity.py"
    output:
        "out/metaAnalysis/MetaPositionalDensity_{sample}.txt"
    message:
        ''
    shell:
        "python {input.script} -i {input.bed} -a {input.gffAnno} -o {output}"