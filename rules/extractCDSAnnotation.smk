
# rule all:
#     input:
#         "out/CDSAnno/CDSAnno.gff3"

rule getCDSAnno:
    input:
        infile = "data/NC_000913.3.gff3",
        script= "scripts/ParseGenomeAnnotation.py"
    output:
        "out/CDSAnno/CDSAnno.gff"
    message:
        'Using {input.script} which uses {input.infile} to generate {output}'
    shell:
        "python {input.script} -i {input.infile} -o {output}"