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
Because of file size/count restrictions, files in the ```processed_data``` and ```run_gcam``` directories are available at the supplementary Zenodo repository (https://doi.org/10.5281/zenodo.15587981).<br />
* All files in the ```figure_map_input``` directory are necessary to generate figures containing maps.<br />
* All files in the ```processed_data``` directory are processed data files that are required for figure generation.<br />
* All files in the ```run_gcam``` directory are necessary files to replicate the experiment, particularly when running GCAM.<br />
* All files in the ```scripts``` directory are necessary files that contain the codes required for data organization, data processing, and figure generation.<br />

A minted version of GCAM version 7.1 used for this experiment and complete output databases can be provided upon request to the corresponding author.<br />

## Reproduce the Experiment
1) First, you need to build GCAM v7.1 with multiple consumer representation for the food sector. Follow the instructions in the GCAM documentation (available at https://jgcri.github.io/gcam-doc/index.html) regarding how to build, compile, and run GCAM.
2) Generate scenario xml that correspond to each scenario in the ensemble. The total number of scenario xmls should match the number of scenarios in the ensemble (i.e., 3,888 scenario xmls in this study). Follow the codes in ```scripts/Config_Generation_MSD_Scenarios.ipynb``` to generate the scenario xmls. Before building the scenario xml, you will need to place the ```run_gcam/addon``` directory and the files within into your ```/gcam-core/input``` directory. Generated scenario xmls should be separately saved in a directory (e.g., ```/config_ensemble``` directory). 
3) Run GCAM (preferably in a High-Perfomance Computing environment with parallelization) and save the output databases in a separate directory. Refer to ```/run_gcam/msd_ensemble.sh``` for an example of a batch file used to run GCAM in a HPC environment. GCAM documentation also provides useful information to run multiple GCAM scenarios simultaneously.
4) Check the results of your runs and save the list of successful and unsuccessful runs using the codes in ```scripts/Ensemble_Simulation_Quality_Check.ipynb```.
5) Run the following queries on successful runs and save them into a separate directory. For the results used in this study, you should run the following 9 queries, which can be found in ```/run_gcam/query_xmls```.<br />
Names of queries required in this study are: ```ag_commodity_prices, ag_production_by_subsector, basin_level_available_runoff, building_service_costs, building_service_output_by_service, food_demand_shares_from_market, subregional_income, subregional_population, and water_withdrawals_by_water_source_runoff_vs_groundwater```.


## Interpret Scenario Names
Each scenario in the ensemble is named according to the following format: ```kim_mcfe_A_B_C_D_E_F_G_H```. Refer below for details:
* ```kim_mcfe```: shared prefix across all scenarios (mcfe: multiple consumers for food and energy)
* ```A``` - CO2 Emissions and Land Conservation Scenarios: ```ref``` (increasing CO2 emissions scenario), ```ndc``` (decreasing CO2 emissions without land conservation scenario), ```ndl``` (decreasing CO2 emissions with land conservation scenario)
* ```B``` - Population and GDP: ```soc2``` (SSP2), ```soc3``` (SSP3), ```soc5``` (SSP5)
* ```C``` - Agricultural Productivity Growth Rate: ```ag1``` (high), ```ag2``` (medium), ```ag3``` (low)
* ```D``` - Food Demand Sensitivity: ```fd0``` (reference), ```fd1``` (high sensitivity)
* ```E``` - Building Energy Efficiency and Energy Demand Sensitivity: ```bldRef``` (reference efficiency, reference sensitivity), ```bldSatLevel``` (reference efficiency, high sensitivity), ```bldBEE``` (high efficiency, reference sensitivity), ```bldBEESatLevel``` (high efficiency, high sensitivity)
* ```F``` - Earth System Models (ESMs): ```gfdl``` (GFDL-ESM4), ```ipsl``` (IPSL-CM6A-LR), ```canesm5``` (CANESM5)
* ```G``` - Reservoir Expansion: ```res0``` (restricted), ```res1``` (expanded)
* ```H``` - Income Distributions: ```icd2``` (SSP2), ```icd3``` (SSP3), ```icd5``` (SSP5)


## Reproduce the Analysis
1) First, you need to organize the query results. Refer to the script in ```scripts/Ensemble_Data_Organization.ipynb```.
2) Using the organized query results, compute the food-energy-water security metrics used in this study: (1) food burden, (2) residential energy burden, and (3) physical water scarcity. When computing the metrics, refer to the codes in the script ```A```. 
3) Follow the scripts in ```scripts/Figure_Generation``` to generate the figures in figure/ directory.
* ```scripts/Figure_Generation/Figure_Generation.ipynb```: scripts to draw main Figures 1-7
* ```scripts/Figure_Generation/4-1_Regression_Tree_Analysis.R```: scripts to perform regression tree analysis for main Figure 3
* ```scripts/Figure_Generation/4-2_Classification_Tree_Analysis.R```: scripts to perform classification tree analysis for main Figures 5-7
* ```scripts/Figure_Generation/Figure_Generation_SI.ipynb```: scripts to draw Figures in SI: Figures S1-S20

## Data Reference
This repository is supplementary to the following Zenodo repository: https://doi.org/10.5281/zenodo.15587981.<br />
