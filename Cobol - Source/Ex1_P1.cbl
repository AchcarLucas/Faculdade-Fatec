       PROGRAM-ID. FIBONACCI AS "EX01_PROVAP1.PROGRAM1".

       DATA DIVISION.
           WORKING-STORAGE SECTION.
               01 DATA-PROGRAM.
                   02 W-CONTADOR       PIC 9(07).
                   02 W-CONTADOR-MASK  PIC ZZZZZZ9.
                   02 W-PREVIEW        PIC 9(07).
                   02 W-PREVIEW-MASK   PIC ZZZZZZ9.
                   02 W-LAST           PIC 9(07).
                   02 W-TMP            PIC 9(07).
           SCREEN SECTION.
               01 CLEAR-SCREEN.
                   02 BLANK SCREEN.
            01 SCREEN-MAIN.
                02 LINE 01 COLUMN 01 VALUE "NUMERO SEQUENCIA (MAIOR QUE ZERO)".
                02 LINE 03 COLUMN 01 VALUE "FIBONACCI".

       PROCEDURE DIVISION.
           INIT.
               DISPLAY CLEAR-SCREEN.
               DISPLAY SCREEN-MAIN.
               PERFORM ERASE-VARIABLES.
               PERFORM DIGITA-VALOR UNTIL W-CONTADOR > 0.
               DISPLAY " " AT 0401.
               PERFORM CALCULO UNTIL W-CONTADOR EQUAL 0.
               STOP " ".
               STOP RUN.
               
           DIGITA-VALOR.
               ACCEPT W-CONTADOR-MASK AT 0135.
               MOVE W-CONTADOR-MASK TO W-CONTADOR.
               
           CALCULO.
               MOVE W-PREVIEW TO W-PREVIEW-MASK.
               DISPLAY W-PREVIEW-MASK.
               ADD W-LAST TO W-PREVIEW GIVING W-TMP.
               MOVE W-LAST TO W-PREVIEW.
               MOVE W-TMP TO W-LAST.
               SUBTRACT 1 FROM W-CONTADOR.
           ERASE-VARIABLES.
               MOVE 0 TO W-PREVIEW.
               MOVE 1 TO W-LAST.
               MOVE ZEROS TO W-CONTADOR.
       END PROGRAM FIBONACCI.
