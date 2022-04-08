configfile: "config/config.yaml"

workdir : config["workdir"]

rule all:
    input:
        expand("./out/trimmedReads/{sample}_trimmed.fastq.gz", sample = config["samples"])

rule trimmomatic:
    input:
        fastq = 'data/{sample}.fastq.gz',
        adapter = "tools/trimmomatic/adapters/RiboSeq_adapter_as.fa"
    output:
        "./out/trimmedReads/{sample}_trimmed.fastq.gz"
    threads:
        int(config["threads"])
    message:
        'Performing trimmomatic on {input.fastq} which generates {output}'
    shell:
        "java -jar ./tools/trimmomatic/trimmomatic-0.39.jar SE -phred33"
        " {input.fastq} {output} ILLUMINACLIP:{input.adapter}:2:30:6"
        " SLIDINGWINDOW:4:15 MINLEN:12 -threads {threads}"
