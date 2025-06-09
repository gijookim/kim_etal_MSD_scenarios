# Identifying the Uncertainties and Drivers of Future Human Outcomes through a Multisector Scenario Ensemble
Gi Joo Kim,<sup>1,5,*</sup> Brian O’Neill,<sup>2</sup> Jennifer Morris,<sup>3</sup> Marshall Wise,<sup>2</sup> John Weyant,<sup>4</sup> and Jonathan Lamontagne<sup>1</sup>

<sup>1</sup>Department of Civil and Environmental Engineering, Tufts University, Medford, MA 02155, USA<br />
<sup>2</sup>Joint Global Change Research Institute, Pacific Northwest National Laboratory, College Park, MD 20740, USA<br />
<sup>3</sup>Center for Sustainability Science and Strategy, Massachusetts Institute of Technology, Cambridge, MA 02139, USA<br />
<sup>4</sup>Stanford University, Stanford, CA 94305, USA<br />
<sup>5</sup>Lead contact<br />
<sup>*</sup>Correspondence: gijoo.kim@tufts.edu<br />

## Abstract
Human well-being outcomes, such as metrics for food, energy, and water security, are key criteria in assessments of complex human-Earth system interactions but are often overlooked in global change scenarios. Here, we generate a scenario ensemble centered around food, energy, and water security outcomes using a global-scale multisector model that simulates critical interactions across multiple sectors. We consider a wide range of future uncertainties in both physical and societal factors, including socioeconomics, emissions scenarios, land conservation, and temperature impacts on water and energy. We evaluate each scenario by computing both regional and subregional outcomes and identify the uncertainties and key drivers that lead to the outcomes of interest. We find that lower-income subgroups face higher burdens and more uncertain outcomes, and that drivers of well-being outcomes are heterogeneous across regions. Ultimately, our approach can help identify scenarios that can facilitate high-priority research on human well-being outcomes, especially in multisector contexts.

## Journal Reference
Kim, G.J., O'Neill, B., Morris, J., Wise, M., Weyant, J., and Lamontagne, J. (submitted) "Identifying the Uncertainties and Drivers of Future Human Outcomes through a Multisector Scenario Ensemble."

## Repository Overview
This repository is designed to provide the necessary inputs to reproduce the data and figures found in Kim et al. (2025). "Identifying the Uncertainties and Drivers of Future Human Outcomes through a Multisector Scenario Ensemble."<br />
Follow the 
All results found in the queried_outputs/ directory are queried outputs from the Global Change Analysis Model (GCAM) runs used for the study. A minted version of GCAM version 7.1 used for this experiment and complete output databases can be provided upon request to the corresponding author. Main text figures and select supplementary figures can be found in figures/ with Jupyter Notebook scripts to reproduce such figures found scripts/.

## Reproduce the Experiment
1) First, you need to build GCAM v7.1 with multiple consumer representation for the food sector. Follow the instructions in the GCAM documentation (available at https://jgcri.github.io/gcam-doc/index.html) regarding how to build, compile, and run GCAM.
2) Generate scenario xml that correspond to each scenario in the ensemble. The total number of scenario xmls should match the number of scenarios in the ensemble (i.e., 3,888 scenario xmls in this study). Follow the code in. Before building the scenario xml, you will need to place the addon/ directory and the files within into your /gcam-core/input/ directory.
3) Run GCAM (preferably in a High-Perfomance Computing environment with parallelization) and save the output databases in a separate directory. Check if your (refer to the in /scripts directory on how to check successful runs).
4) Run the following queries and save them into a separate directory. Find the 
   * 

## Reproduce the Analysis
1) First, you need to organize the and compute
2) Follow the scripts in scripts/ to generate the figures in figure/ directory.

## Data Reference
This supplementary with the Zenodo repository in https://doi.org/10.5281/zenodo.15587981.<br />
Kim, G. J. (2025). Model, Data, and Codes for Kim et al. "Identifying the Uncertainties and Drivers of Future Human Outcomes through a Multisector Scenario Ensemble." Zenodo. https://doi.org/10.5281/zenodo.15587981.
