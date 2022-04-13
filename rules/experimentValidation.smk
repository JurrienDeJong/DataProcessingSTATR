

rule checkPeriodicity:
    input:
        gffAnno = "out/CDSAnno/CDSAnno.gff",
        bed = "out/decompiled/{sample}.bed",
        script = "scripts/CheckPeriodicity.py"
    output:
        "out/metaAnalysis/MetaPositionalDensity_{sample}.txt"
    benchmark:
        "benchmarks/metaAnalysis/{sample}.check_periodicity.benchmark.txt"
    message:
        'Using {input.script} to generate {output}'
    shell:
        "python {input.script} -i {input.bed} -a {input.gffAnno} -o {output}"