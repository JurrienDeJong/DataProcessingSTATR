rule generateProfile:
    input:
        gffAnno =  config["outDir"] + "refDb/" + config["ref_genome"] + config["extensions"]["created_anno"],
        bed =  config["outDir"] + "Decompiled/{sample}.bed",
        script =  config["workdir"] + "scripts/python/GenerateProfile.py",
    output:
        config["workdir"] + config["outDir"] + "metaAnalysis/{sample}_profile." + config["extensions"]["gff"]
    benchmark:
        "benchmarks/metaAnalysis/{sample}.generate_profile.benchmark.txt"
    message:
        'Generates sample profile using script {input.script} which creates {output}'
    shell:
        "python {input.script} -i {input.bed} -e 5 -a {input.gffAnno} -n 1000000 -o {output}"