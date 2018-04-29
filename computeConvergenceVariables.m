function [updateStepMean, updateStepMeanDelta] = computeConvergenceVariables(inputArg1,inputArg2)

            if mod(t,Params.tolUpdateMeanWindow) == 0
                if t >= Params.tolUpdateMeanWindow
                    updateStepMean = [updateStepMean, mean(updateSteps(t-Params.tolUpdateMeanWindow+1:t)) ];
                end
                if t>= 2*Params.tolUpdateMeanWindow
                    updateStepMeanDelta = [updateStepMeanDelta, abs(updateStepMean(end) - updateStepMean(end-1))];
                end
            end
            
end

