

rule buildRefDatabase:
    input:
        genome = config["workdir"] + 'data/NC_000913.3.fa'
    output:
        touch('out/refDb/index.done'), # Flag file
    params:
        index_prefix= 'out/refDb/NC_000913.3'
    threads:
        int(config["threads"])
    message:
        'Performing bowtie build on {input.genome} which generates {output}'
    shell:
        "bowtie2-build {input.genome} {params.index_prefix} --threads {threads}"

rule readMapping:
    input:
        idx= 'out/refDb/index.done',
        trimmedFiles = config["workdir"] + 'out/trimmedReads/{sample}_trimmed.fastq.gz',
    output:
        config["workdir"] + 'out/aligned/{sample}_mapping.sam'
    params:
        index_prefix= 'out/refDb/NC_000913.3'
    threads:
        int(config["threads"])
    benchmark:
        "benchmarks/bowTie/{sample}.benchmark.txt"
    shell:
        "bowtie2 -x {params.index_prefix} -U {input.trimmedFiles} -S {output} --threads {threads}"