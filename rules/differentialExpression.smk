import glob

rule differentialExp:
    input:
        gffAnno = "out/CDSAnno/CDSAnno.gff",
        bed = "out/decompiled/{sample}.bed",
        script= "scripts/GenerateProfile.py"
    output:
        "out/differentialExp/{sample}.cov"
    benchmark:
        "benchmarks/bedTools/{sample}.diffExp.benchmark.txt"
    message:
        'Creates cov files using {input.bed} with script {input.script}'
    shell:
        "bedtools coverage -a {input.gffAnno} -b {input.bed} -s > {output}"


rule collateCov:
    input:
        "out/differentialExp/{sample}.cov"
    output:
        "out/differentialExp/collatedCov.txt"
    run:
        files = glob.glob("out/differentialExp/*.cov")
        with open(output[0], 'w') as out:
            for filename in files:
                out.write(filename + "\n")


rule formatDeSeqInput:
    input:
        infile = "out/differentialExp/collatedCov.txt",
        script = "scripts/FormatDeSeqInput.py"
    output:
        "out/differentialExp/DESeqInput.txt"
    shell:
        "python {input.script} -i {input.infile} -o {output}"
