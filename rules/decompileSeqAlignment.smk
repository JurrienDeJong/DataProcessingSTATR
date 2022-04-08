configfile: "config/config.yaml"


rule samtoolsView:
    input:
        aligned = 'out/aligned/{sample}_mapping.sam'
    output:
        "./out/decompiled/{sample}_mapping.bam"
    shell:
        "samtools view -bS {input.aligned} > {output}"

rule samtoolsSort:
    input:
        decompiled = 'out/decompiled/{sample}_mapping.bam'
    output:
        './out/decompiled/{sample}_mapping.sorted.bam'
    shell:
        "samtools sort {input.decompiled} {output}"

rule bedtoolsBamToBed:
    input:
        sorted = 'out/decompiled/{sample}_mapping.sorted.bam'
    output:
        './out/decompiled/{sample}.bed'
    shell:
        "bedtools bamtobed -i {input.sorted} > {output}"