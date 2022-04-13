rule getCDSAnno:
    input:
        script= config["workdir"] + "scripts/ParseGenomeAnnotation.py",
        infile = config["workdir"] + 'data/NC_000913.3.gff3'
    output:
        config["workdir"] + "out/CDSAnno/CDSAnno.gff"
    message:
        'Using {input.script} which uses {input.infile} to generate {output}'
    shell:
        "python {input.script} -i {input.infile} -o {output}"