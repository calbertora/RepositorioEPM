CREATE OR REPLACE PACKAGE pkg_EPM_Imagenes IS
       
    FUNCTION fblEs_PNG( isbInicioImagen VARCHAR2) RETURN BOOLEAN;
    
    FUNCTION fblPNG_Termina(isbFinalImagen VARCHAR2) RETURN BOOLEAN;

    FUNCTION fclImgXRoja_PNB64 RETURN CLOB;
    
    FUNCTION fclValidaImagen( iclImagen CLOB) RETURN CLOB;
    
END pkg_EPM_Imagenes;    
/

CREATE OR REPLACE PACKAGE BODY pkg_EPM_Imagenes IS
       
    FUNCTION fblEs_PNG( isbInicioImagen VARCHAR2) RETURN BOOLEAN IS
        blEs_PNG BOOLEAN := FALSE;
    BEGIN
    
        if ( instr( isbInicioImagen,CHR(137)|| 'PNG' ) > 0 ) THEN
        
            dbms_output.put_line(  'Es una imagen PNG' );
            
            blEs_PNG := TRUE;
            
        end if;
        
        RETURN blEs_PNG;     
    
    END;
    
    FUNCTION fblPNG_Termina(isbFinalImagen VARCHAR2) RETURN BOOLEAN IS
        blPNG_Termina BOOLEAN := FALSE;    
    BEGIN

        if ( INSTR(isbFinalImagen,'IEND' || CHR(174) ||'B' || CHR(96) || CHR(130) ) > 0  ) THEN
             dbms_output.put_line(  'La imagen PNG Termina Correctamente' );
             blPNG_Termina := TRUE;
        ELSE
             dbms_output.put_line(  'La imagne PNG NO Termina Correctamente' );
        end if;  
        
        RETURN blPNG_Termina;
          
    END;

    FUNCTION fclImgXRoja_PNB64 RETURN CLOB IS
        clImgXRoja_PNB64 CLOB;
    BEGIN
    
        clImgXRoja_PNB64 :='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';
    
        RETURN clImgXRoja_PNB64;
    
    END fclImgXRoja_PNB64;
    
    FUNCTION fclValidaImagen(iclImagen CLOB) RETURN CLOB IS
        clImagen    CLOB;
        sbInicio    VARCHAR2(32767);
        sbFinal     VARCHAR2(32767);
    BEGIN
                
        sbInicio := UTL_ENCODE.TEXT_DECODE (substr(iclImagen,1,100), null, UTL_ENCODE.BASE64);

        sbFinal := UTL_ENCODE.TEXT_DECODE (substr(iclImagen,-100), null, UTL_ENCODE.BASE64);
        
        if  fblEs_PNG(sbInicio) then
            
            if fblPNG_Termina(sbFinal) then
                clImagen := iclImagen;
            else
                clImagen := fclImgXRoja_PNB64;
            end if;

        else
            clImagen := iclImagen;
        end if;
        
        return clImagen;
    
    END fclValidaImagen;
    
END pkg_EPM_Imagenes;
/