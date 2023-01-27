%% Reconstruction Loop
cpm.numberOfIterations = 15000;
figure('Color','w','Units','normalized','Position',[0.25,0.25,0.5,0.5]); drawnow;
nRows=2;
nCols = ex.numberOfWavelengths+2;
for n = 1:cpm.numberOfIterations

    cpm.RAAR_M_matCPM;
    
    if mod(cpm.iterationNumber,25)==0
        
        object = wv.propagateField(cpm.dataWave,-1);
        
        for lambdaIdx=1:ex.numberOfWavelengths

            subplot(nRows,nCols,lambdaIdx)
            imagesc(abs(object(:,:,lambdaIdx)));
            axis xy image off;

            subplot(nRows,nCols,lambdaIdx+ex.numberOfWavelengths+2)
            imagesc(angle(object(:,:,lambdaIdx)));
            axis xy image off;

        end
        
        subplot(nRows,nCols,ex.numberOfWavelengths+1)
        imagesc(abs(cpm.dataDiffuser(:,:,1)));
        axis xy image off;
        
        subplot(nRows,nCols,2*ex.numberOfWavelengths+3)
        imagesc(angle(cpm.dataDiffuser(:,:,1)));
        axis xy image off;
        
        subplot(nRows,nCols,[ex.numberOfWavelengths+2,2*(ex.numberOfWavelengths+2)])
        semilogy(cpm.totalError);
        axis tight; pbaspect([1,2,1]);
        title('log - Error','Interpreter','latex');
        
        drawnow;
        
        if strcmp(get(gcf,'currentCharacter'),char(8)), break; end
        
    end

end
