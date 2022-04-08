

rule generateProfile:
    input:
        gffAnno = "out/CDSAnno/CDSAnno.gff",
        bed = "out/decompiled/{sample}.bed",
        script = "scripts/GenerateProfile.py",
        # Select either 5'or 3':
        primeType = "5",
        normalization = 1000000
    output:
        "out/metaAnalysis/{sample}_profile.gff"
    message:
        ''
    shell:
        "python {input.script} -i {input.bed} -e {input.primeType} -a {input.gffAnno} -n {input.normalization} -o {output}"

