"""
R script creates two visualizations, but first installing the needed packages.
"""

rule install_packages:
          input:
              "out/flag_files/index.done"

          output:
                touch("out/flag_files/install.done")

          message: "Started with installing the necessary packages"

          threads: config["threads"]

          shell:
              "Rscript scripts/R/InstallPackages.R"

rule visual:
          input:
              deSeq = config["outDir"] + "DifferentialExpression/DESeqInput.txt",
              des = "data/" + "designSheet.txt",
              check = config["outDir"] +  "flag_files/install.done"

          params:
              "images/"

          output:
              "images/DendrogramAndHeatmap.pdf",
              "images/PCA.pdf"

          threads: int(config["threads"])

          message: "Create visualizations using the R script:"

          log:
            "logs/R/image.log"

          shell:
              "Rscript scripts/R/RunDESeq.R {input.deSeq} {input.des} {params} {log}"