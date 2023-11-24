# AQY_prediction
This repository contains model data files and MATLAB scripts to predict the Apparent Quantum Yield matrix (AQY-M) of Chromophoric Dissolved Organic Matter (CDOM) photobleaching. The files include the model parameters and principal-component variables needed for the model, MATLAB scripts, and an example file containing input variables from 36 samples (to predict 36 corresponding AQY-M). The details of the model and information about the variability of the CDOM photobleaching AQY-M in natural waters are presented in Zhu et. al. 2023 (10.1016/j.scitotenv.2023.168670).

Data Files
1. PCA_PCs.mat:
   - Contains PCA components used in AQY prediction.
   - Variable ‘coeff’: Matrix with the first three principal components in its columns.
     - PC1: First Principal Component (Column 1)
     - PC2: Second Principal Component (Column 2)
     - PC3: Third Principal Component (Column 3)

2. AQYModel.mat:
   - Stores the trained AQY prediction model variables
   - Variable ‘Q’: Matrix (1 row x 49 columns) containing threshold values for categorizing data based on the standardized t_std.
   - Variable ‘trainedModel’: Matrix (48 rows x 6 columns) with slope and intercept information for linear regressions of different ‘t_std’ groups.
     - Columns 1 and 2: Slope and intercept for PC1 regression.
     - Columns 3 and 4: Slope and intercept for PC2 regression.
     - Columns 5 and 6: Slope and intercept for PC3 regression.

3. parameter_example.mat:
   - Example parameters for an AQY prediction.
   - Variable ‘para’: Matrix with 4 columns representing prediction parameters.
     - Column 1: Eabs290-350 (Amount of photon absorbed by CDOM from 290 to 350 nm)(Unit: mol(photon))
     - Column 2: ag350 (CDOM absorption coefficient at 350 nm)(Unit: /m)
     - Column 3: slope275-295 (Spectral slope between 275 and 295 nm)(Unit: /nm)
     - Column 4: Water temperature (Unit: °C)

Matlab scripts files
1. example.m:
   - Demonstrates how to use the AQY prediction model with example data.
   - Loads the necessary data files and applies the ‘predict’ function to compute AQY predictions.
   - Illustrates the process of reshaping and visualizing the predicted AQY.

2. predict.m:
   - A MATLAB function that predicts the scores of the first three AQY PCs.
   - Inputs: 
     - ‘regression’: Matrix with the parameters for prediction.
     - ‘fit_all’: Matrix containing the trained model parameters.
     - ‘Q’: Matrix for categorizing data based on ‘t_std’.
   - Output: 
     - ‘yfit’: Predicted scores for the AQY PCs.
   - The function calculates an adjustment ratio based on water temperature, applies the appropriate linear regression models, and adjusts the scores of PCs accordingly.

Usage Instructions
- To run the example prediction, execute ‘example.m’ in MATLAB.
- The ‘example.m’ script will automatically load the necessary data files and use the ‘predict’ function.
- The ‘predict.m’ function can be used independently for custom AQY predictions with different parameter sets.

Additional Notes
- Ensure that all data files are in the same directory as the MATLAB script files.

