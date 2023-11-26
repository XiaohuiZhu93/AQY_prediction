# Apparent Quantum Yield Matrix (AQY-M) Prediction for CDOM Photobleaching

This repository contains model data files and MATLAB scripts for predicting the Apparent Quantum Yield Matrix (AQY-M) of Chromophoric Dissolved Organic Matter (CDOM) photobleaching. It includes the necessary model parameters, principal-component variables, MATLAB scripts, and an example file containing input variables from 36 samples (to predict 36 corresponding AQY-M). The details of the model and findings regarding the variability of CDOM photobleaching AQY-M in natural waters are detailed in Zhu et. al. 2023 (10.1016/j.scitotenv.2023.168670).

## Data Files

### PCA_PCs.mat

- Contains PCA components for AQY-M prediction.
- Variable ‘coeff’: A matrix with the first three principal components.
  - PC1: First Principal Component (Column 1)
  - PC2: Second Principal Component (Column 2)
  - PC3: Third Principal Component (Column 3)

### AQYModel.mat

- Stores the trained AQY-M prediction model variables.
- Variable ‘Q’: A matrix (1 row x 49 columns) with threshold values for categorizing data based on standardized t_std.
- Variable ‘trainedModel’: A matrix (48 rows x 6 columns) containing slope and intercept information for linear regressions of different t_std groups.
  - Columns 1 and 2: Slope and intercept for PC1 regression.
  - Columns 3 and 4: Slope and intercept for PC2 regression.
  - Columns 5 and 6: Slope and intercept for PC3 regression.

### input_variables.mat

- Contains example parameters for AQY-M prediction.
- Variable ‘para’: A matrix with 4 columns representing prediction parameters.
  - Column 1: Eabs290-350 (Amount of photon absorbed by CDOM from 290 to 350 nm)(Unit: mol(photon))
  - Column 2: ag350 (CDOM absorption coefficient at 350 nm)(Unit: /m)
  - Column 3: slope275-295 (Spectral slope between 275 and 295 nm)(Unit: /nm)
  - Column 4: Water temperature (Unit: °C)

## Matlab Scripts

### example.m

- Demonstrates AQY-M prediction model usage with example data.
- Loads necessary data files and applies the ‘predict’ function for AQY-M prediction.
- Illustrates reshaping and visualizing the predicted AQY-M.

### predict.m

- MATLAB function for predicting the scores of the first three AQY-M PCs.
- Inputs:
  - ‘regression’: Matrix with prediction parameters.
  - ‘fit_all’: Matrix with trained model parameters.
  - ‘Q’: Matrix for categorizing data based on ‘t_std’.
- Output:
  - ‘yfit’: Predicted scores for the AQY-M PCs.

## Usage Instructions

- To run the example prediction, execute ‘example.m’ in MATLAB.
- Update the ‘input_variables.mat’ file with your own parameters for your own AQY-M predictions.
- The output variables are contained in the MATLAB cell `AQY_M`, which will have as many AQY_M values as there are rows in the `input_variables.mat`.

## Additional Notes

- Ensure that all data files are in the same directory as the MATLAB script files.
