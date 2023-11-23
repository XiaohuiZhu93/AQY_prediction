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
