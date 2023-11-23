% Load the first three Principal Components (PCs) of the AQY data
load('PCA_PCs.mat'); % The file 'PCA_PCs.mat' includes the variable 'coeff'
PC1 = coeff(:,1); % First Principal Component
PC2 = coeff(:,2); % Second Principal Component
PC3 = coeff(:,3); % Third Principal Component

% Load the trained AQY prediction model
load('AQYModel.mat'); 
% 'AQYModel.mat' contains two variables: 'Q' and 'trainedModel'
% 'Q' helps to categorize data based on t_std
% 'trainedModel' has linear regression parameters for different t_std groups

% 'Q': A matrix used for categorizing data into different groups based on 't_std'
% - Q has 1 row and 49 columns. 
% - Each element in 'Q' represents a threshold value. 
% - If 't_std' of a data point is between Q(1,i) and Q(1,i+1), it belongs to the i-th group.

% 'trainedModel': Contains parameters for linear regressions of different 't_std' groups
% - trainedModel has 48 rows, each corresponding to a specific 't_std' group.
% - Each row in 'trainedModel' contains slope and intercept information for the regression models.
% - Columns 1 and 2: Slope and intercept for PC1 linear regression.
% - Columns 3 and 4: Slope and intercept for PC2 linear regression.
% - Columns 5 and 6: Slope and intercept for PC3 linear regression.


% Load prediction parameters example
load('parameter_example.mat'); % Includes variable 'para' with 4 columns:
% 1st column: Eabs290-350
% 2nd column: ag350
% 3rd column: slope275-295
% 4th column: water temperature

% Predict the scores of the first three AQY PCs using the 'predict' function
AQY_Comp = predict(para, trainedModel, Q);

% Initialize a cell array to store predicted AQY for each parameter set
AQY = cell(1, length(para));

% Loop through each parameter set to compute the predicted AQY
for i = 1:length(para)
    % Calculate the predicted AQY using the weighted sum of PCs and predicted scores
    AQY_temp = PC1(:) .* AQY_Comp(i,1) + PC2(:) .* AQY_Comp(i,2) + PC3(:) .* AQY_Comp(i,3);
    
    % Reshape the predicted AQY to its original dimensions
    % Rows: Excitation wavelength (290-490nm), Columns: Response wavelength (280-700nm)
    AQY_temp = reshape(AQY_temp, [201, 421]);
    AQY{1,i} = AQY_temp;
end

% Define the 'predict' function
function yfit = predict(regression, fit_all, Q)
    % Calculate the adjustment ratio based on water temperature
    ratio = exp(1422 .* (regression(:,4) - 20) ./ (293.15 .* (regression(:,4) + 273.15)));
    [l, ~] = size(regression);
    yfit = zeros(l, 3);

    % Calculate the t_std based on Eabs290-350 and ag350
    regression(:,1) = regression(:,1) ./ (regression(:,2) .^ 0.92);

   
    for j = 1:l
        for i = 1:48
             % Determine the appropriate linear regression model based on t_std
            if regression(j,1) >= Q(1,i) && regression(j,1) < Q(1,i+1)
                % Apply linear regression for each PC
                for k = 1:3
                    yfit(j,k) = fit_all(i, k*2-1) * regression(j,3) + fit_all(i, k*2);
                end
            end
        end
    end

    % Adjust the score of PCs based on the water temperature
    yfit = yfit .* ratio;
end