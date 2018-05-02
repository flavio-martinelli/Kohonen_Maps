function updateStep = getUpdateStep(new_centers, old_centers)

    updateStep = norm(new_centers - old_centers);
    
end

