configfile: "config/config.yaml"


rule buildRefDatabase:
    input:
        genome = 'data/NC_000913.3.fa'
    output:
        "./out/refDb/NC_000913.3"
    message:
        'Performing bowtie build on {input.genome} which generates {output}'
    shell:
        "bowtie2-build -f {input.genome} ./ReferenceDB/NC_000913.3"

rule readMapping:
    input:
        trimmedFiles = 'out/trimmedReads/{sample}_trimmed.fastq.gz',
        refDb = 'out/refDb/NC_000913.3'
    output:
        './out/aligned/{sample}_mapping.sam'
    shell:
        "bowtie2 -q -U {input.trimmedFiles} -x {input.refDb} -S {output} --local"