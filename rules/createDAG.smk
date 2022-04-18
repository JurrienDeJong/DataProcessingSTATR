'''
Visualizes the pipeline in Dag format.
'''

rule dag_file:
    output:
        "images/DAG.pdf"
    message:
        "Creates a DAG file of the pipeline"
    shell:
         "snakemake --forceall --dag --snakefile main.smk | dot -Tpdf > {output}"

rule rule_graph:
    output:
        "images/ruleGraph.pdf"
    message:
        "Creates a DAG file of the pipeline"
    shell:
         "snakemake --forceall --rulegraph --snakefile main.smk | dot -Tpdf > {output}"
