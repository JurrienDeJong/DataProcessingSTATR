"""
This snakefile uses the tool trimmomatic to cut of parts of the fastq.gz files;
"""


rule trimmomatic:
     input:
         fastq = "data/{sample}" + config["extensions"]["raw"],
         adap = config["trimm"]["adapter"]

     output:
         config["outDir"] + "TrimmedReads/{sample}_trimmed.fastq.gz"

     threads: int(config["threads"])

     benchmark:
        "benchmarks/trimmomatic/{sample}.benchmark.txt"

     params:
           jar = config["trimm"]["jar"],
           phred = config["trimm"]["phred"],
           minlen = config["trimm"]["minlen"],
           maxmismatch = config["trimm"]["maxmismatch"],
           pairend = config["trimm"]["pairend"],
           minscore = config["trimm"]["minscore"],
           slidwindow = config["trimm"]["slidwindow"],
           minqual = config["trimm"]["minqual"]

     message: "Started trimmomatic using {input.fastq} which creates {output}"

     log:
       "logs/trimmomatic/{sample}_trimmed.log"

     shell:
        "java -jar {params.jar} SE {params.phred} {input.fastq} {output} ILLUMINACLIP:{input.adap}:{params.maxmismatch}:{params.pairend}:{params.minscore} SLIDINGWINDOW:{params.slidwindow}:{params.minqual} MINLEN:{params.minlen} -threads {threads} 2> {log}"