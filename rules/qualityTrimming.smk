rule trimmomatic:
    input:
        fastq = config["workdir"] + 'data/{sample}.fastq.gz',
        adapter = config["workdir"] + "tools/trimmomatic/adapters/RiboSeq_adapter_as.fa"
    output:
        config["workdir"] + "out/trimmedReads/{sample}_trimmed.fastq.gz"
    threads:
        int(config["threads"])
    benchmark:
        "benchmarks/trimming/{sample}.benchmark.txt"
    message:
        'Performing trimmomatic on {input.fastq} which generates {output}'
    shell:
        "java -jar ./tools/trimmomatic/trimmomatic-0.39.jar SE -phred33"
        " {input.fastq} {output} ILLUMINACLIP:{input.adapter}:2:30:6"
        " SLIDINGWINDOW:4:15 MINLEN:12 -threads {threads}"
