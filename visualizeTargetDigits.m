function visualizeTargetDigits(Data, Params)

figure
for i=1:4
    subplot(2,2,i)
    digits_i = Data.data(Data.labels==Data.targetdigits(i),:);
    imagesc(reshape(digits_i(1,:),sqrt(Params.dim),sqrt(Params.dim))') 
    colormap gray
    axis off
end

a = axes;
t = title(['Digits chosen for ', Data.name]);
a.Visible = 'off';
t.Visible = 'on';

end

