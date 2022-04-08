rule runDeSeq:
    input:
        R_Script = "scripts/RunDeSeq.R",
        DeSeqIn = "out/differentialExp/DESeqInput.txt",
        design = "data/designSheet.txt"
    output:
        "out/differentialExp/"
    shell:
        "sudo Rscript {input.R_Script} -i {input.DeSeqIn} -d {input.design} -o {output}"