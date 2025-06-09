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
All files in the ```figure_map_input``` directory are necessary files that are required for figure generation.<br />
All files in the ```processed data``` directory <br />

A minted version of GCAM version 7.1 used for this experiment and complete output databases can be provided upon request to the corresponding author. <br />
Main text figures and select supplementary figures can be found in ```figures/``` with Jupyter Notebook scripts to reproduce such figures can be found in ```scripts/```.


## Reproduce the Experiment
1) First, you need to build GCAM v7.1 with multiple consumer representation for the food sector. Follow the instructions in the GCAM documentation (available at https://jgcri.github.io/gcam-doc/index.html) regarding how to build, compile, and run GCAM.
2) Generate scenario xml that correspond to each scenario in the ensemble. The total number of scenario xmls should match the number of scenarios in the ensemble (i.e., 3,888 scenario xmls in this study). Follow the codes in ```scripts/Config_Generation_MSD_Scenarios.ipynb``` to generate the scenario xmls. Before building the scenario xml, you will need to place the ```run_gcam/addon``` directory and the files within into your ```/gcam-core/input``` directory. Generated scenario xmls should be separately saved in a directory (e.g., ```/config_ensemble``` directory).
3) Run GCAM (preferably in a High-Perfomance Computing environment with parallelization) and save the output databases in a separate directory. Refer to ```/run_gcam/msd_ensemble.sh``` for an example of a batch file used to run GCAM in a HPC environment.
4) Check the results of your runs and save the list of successful runs, using the codes in ```scripts/Ensemble_Simulation_Quality_Check.ipynb```.
5) Run the following queries on successful runs and save them into a separate directory. For the results used in this study, you should run the following 9 queries, which can be found in ```/run_gcam/query_xmls```. Save the query results in a separate directory for further analysis.
   * ag_commodity_prices
   * ag_production_by_subsector
   * basin_level_available_runoff
   * building_service_costs
   * building_service_output_by_service
   * food_demand_shares_from_market
   * subregional_income
   * subregional_population
   * water_withdrawals_by_water_source_runoff_vs_groundwater

## Reproduce the Analysis
1) First, you need to organize the and compute the metrics used in this study: food burden, residential energy burden, and physical water scarcity. Refer to the codes in the script ```/run_gcam/query_xmls``` to process the data for analysis.
2) Follow the scripts in ```scripts/``` to generate the figures in figure/ directory.
3) 

## Data Reference
This repository is supplementary to the following Zenodo repository: https://doi.org/10.5281/zenodo.15587981.<br />
