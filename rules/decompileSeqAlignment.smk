
rule samtoolsView:
    input:
        aligned = config["workdir"] + 'out/aligned/{sample}_mapping.sam'
    output:
        config["workdir"] + "out/decompiled/{sample}_mapping.bam"
    benchmark:
        "benchmarks/samView/{sample}.view.benchmark.txt"
    shell:
        "samtools view -bS {input.aligned} > {output}"

rule samtoolsSort:
    input:
        decompiled = config["workdir"] + 'out/decompiled/{sample}_mapping.bam'
    output:
        config["workdir"] + 'out/decompiled/{sample}_mapping.sorted.bam'
    threads:
        int(config["threads"])
    benchmark:
        "benchmarks/samTools/{sample}.sort.benchmark.txt"
    shell:
        "samtools sort {input.decompiled} -o {output} --threads {threads}"

rule bedtoolsBamToBed:
    input:
        sorted = config["workdir"] + 'out/decompiled/{sample}_mapping.sorted.bam'
    output:
        config["workdir"] + 'out/decompiled/{sample}.bed'
    benchmark:
        "benchmarks/bedTools/{sample}.benchmark.txt"
    shell:
        "bedtools bamtobed -i {input.sorted} > {output}"