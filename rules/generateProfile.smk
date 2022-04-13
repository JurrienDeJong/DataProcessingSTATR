

rule generateProfile:
    input:
        gffAnno =  config["workdir"] + "out/CDSAnno/CDSAnno.gff",
        bed =  config["workdir"] + "out/decompiled/{sample}.bed",
        script =  config["workdir"] + "scripts/GenerateProfile.py",
    output:
        config["workdir"] + "out/metaAnalysis/{sample}_profile.gff"
    benchmark:
        "benchmarks/metaAnalysis/{sample}.generate_profile.benchmark.txt"
    message:
        'Generates sample profile using script {input.script} which creates {output}'
    shell:
        "python {input.script} -i {input.bed} -e 5 -a {input.gffAnno} -n 1000000 -o {output}"

