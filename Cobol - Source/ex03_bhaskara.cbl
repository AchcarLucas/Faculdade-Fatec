        *> AUTHOR -> LUCAS CAMPOS 14/03/2017
        IDENTIFICATION DIVISION.
        PROGRAM-ID. SEGUNDO-GRAU.	
        ENVIRONMENT DIVISION.
	        CONFIGURATION SECTION.
		        SPECIAL-NAMES.
			        DECIMAL-POINT IS COMMA.
        DATA DIVISION.
	        WORKING-STORAGE SECTION.
	
		        01 DATE-TIME.
			        02 YEARS		PIC 9(02).
			        02 MONTHS		PIC 9(02).
			        02 DAYS			PIC 9(02).
		
		        01 DATA-CALC.
                    *> SIGN IS LEADING SEPARATE CHARACTER (HABILITA O USO DO SINAL NEGATIVO (-))
			        02 W-AX			PIC S9(05) VALUE ZEROS SIGN IS LEADING SEPARATE CHARACTER.
                    02 W-AX-DOT     PIC -zzzzz.
			        02 W-BX			PIC S9(05) VALUE ZEROS SIGN IS LEADING SEPARATE CHARACTER.
                    02 W-BX-DOT     PIC -zzzzz.
			        02 W-C			PIC S9(05) VALUE ZEROS SIGN IS LEADING SEPARATE CHARACTER.
                    02 W-C-DOT      PIC -zzzzz.
			
			        02 W-X1			PIC S9(09)V99.
			        02 W-X1-DOT		PIC -ZZZZZZZZ9,99.
			
			        02 W-X2			PIC S9(09)V99.
			        02 W-X2-DOT		PIC -ZZZZZZZZ9,99.
            
                01 DATA-BHASKARA.
                    02 W-DELTA      PIC S9(09)V99.
                    
                01 MSGS.
                    02 MSGSCLEAR PIC X(30) VALUE SPACES.
                    02 MSG01    VALUE "AX DEVE SER DIFERENTE QUE ZERO".
	
	        SCREEN SECTION.
		        01 MAIN-SCREEN.
			        02 LINE 01 COLUMN 05 PIC 9(02)/ USING DAYS FOREGROUND-COLOR IS 2.
			        02 LINE 01 COLUMN 08 PIC 9(02)/ USING MONTHS FOREGROUND-COLOR IS 2.
			        02 LINE 01 COLUMN 11 PIC 9(02) USING YEARS FOREGROUND-COLOR IS 2.
			        02 LINE 01 COLUMN 20 VALUE "CALCULO (EQUACAO SEGUNDO GRAU)" FOREGROUND-COLOR IS 2.
			        02 LINE 03 COLUMN 10 VALUE "AX: --" FOREGROUND-COLOR IS 3.
			        02 LINE 05 COLUMN 10 VALUE "BX: --" FOREGROUND-COLOR IS 3.
			        02 LINE 07 COLUMN 10 VALUE "C:  --" FOREGROUND-COLOR IS 3.
			        02 LINE 11 COLUMN 10 VALUE "X1: --" FOREGROUND-COLOR IS 4.
			        02 LINE 13 COLUMN 10 VALUE "X2: --" FOREGROUND-COLOR IS 4.
            
		        01 CLEAR-SCREEN.
			        02 BLANK SCREEN.
                    
        PROCEDURE DIVISION.
	        INIT.
		        ACCEPT DATE-TIME FROM DATE.
		        DISPLAY CLEAR-SCREEN.
		        DISPLAY MAIN-SCREEN.
		
                GET-AX.
		            ACCEPT W-AX AT 0314 FOREGROUND-COLOR IS 3.
                    IF W-AX <> 0
                        MOVE W-AX TO W-AX-DOT
                        DISPLAY W-AX-DOT AT 0323
                        DISPLAY MSGSCLEAR AT 1510
                    ELSE
                        DISPLAY MSG01 AT 1510
                        GO TO GET-AX
                    END-IF.
                    
		        ACCEPT W-BX AT 0514 FOREGROUND-COLOR IS 3.
                MOVE W-BX TO W-BX-DOT.
                DISPLAY W-BX-DOT AT 0523.
                
		        ACCEPT W-C AT 0714 FOREGROUND-COLOR IS 3.
                MOVE W-C TO W-C-DOT.
                DISPLAY W-C-DOT AT 0723.
                
                DISPLAY "E > " AT 0910.
                DISPLAY W-AX-DOT "^2 + (" W-BX-DOT ") + (" W-C-DOT ")".
                
		        COMPUTE W-DELTA = ((W-BX**2) - (4*W-AX*W-C))**0,5.
                IF W-DELTA < 0,0 THEN
                    DISPLAY "DELTA NEGATIVO (SEM SOLUCAO)" AT 1410 FOREGROUND-COLOR IS 4
                ELSE
                    COMPUTE W-X1 = ((-1)*W-BX + W-DELTA) / (2*W-AX)
                    COMPUTE W-X2 = ((-1)*W-BX - W-DELTA) / (2*W-AX)
                    MOVE W-X1 to W-X1-DOT
                    MOVE W-X2 to W-X2-DOT
                    DISPLAY W-X1-DOT AT 1114 FOREGROUND-COLOR IS 15
                    DISPLAY W-X2-DOT AT 1314 FOREGROUND-COLOR IS 15
                END-IF.
        
                STOP " ".
		        STOP RUN.
