       PROGRAM-ID. PROGRAM2 AS "EX01_PROVAP1.PROGRAM2".

       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 DATOS-CLIENTE.
               02 W-NOME         PIC X(30).
               02 W-SEXO         PIC X(01).
                  88 SEXO VALUE 'M', 'm', 'F', 'f'.
               02 W-SALARIO      PIC 9(06)V99.
               02 W-SALARIO-MASK PIC ZZZZZ9.99.
               02 W-IDADE        PIC 9(03).
               02 W-IDADE-MASK   PIC ZZ9.
               02 W-COD          pic 9(01).
                  88 COD VALUE 1, 2, 3, 4, 5, 6.
               02 CLEAR     PIC X(30) VALUE SPACES.
           01 MSGS.
               02 PROF01    VALUE "CARTOGRAFO".
               02 PROF02    VALUE "ASSISTENTE SOCIAL".
               02 PROF03    VALUE "PSICOLOGO".
               02 PROF04    VALUE "ATENDENTE".
               02 PROF05    VALUE "SECRETARIA BILINGUE".
               02 PROF06    VALUE "GEOLOGO".
       
           SCREEN SECTION.
           01 LIMPA-TELA.
               02 BLANK SCREEN.
           01 CADASTRO.
               02 LINE 01 COLUMN 01 VALUE "DIGITE O NOME:       ".
               02 LINE 02 COLUMN 01 VALUE "DIGITE O SEXO(M/F):  ".
               02 LINE 03 COLUMN 01 VALUE "PRETENSAO SALARIAL:  ".
               02 LINE 04 COLUMN 01 VALUE "IDADE:               ".
               02 LINE 05 COLUMN 01 VALUE "CODIGO DA PROFISSAO: ".
           01 EXIBE-INFO.
               02 LINE 08 COLUMN 01 VALUE "NOME:      ".
               02 LINE 09 COLUMN 01 VALUE "PROFISSAO: ".
       PROCEDURE DIVISION.
           INIT.
               PERFORM ERASE-VARIABLES.
               DISPLAY LIMPA-TELA.
               DISPLAY CADASTRO.
               PERFORM ENTRADA-DADOS.
               PERFORM ENTRADA-COD UNTIL COD.
               STOP " ".
               STOP RUN.
               
           ENTRADA-DADOS.
               PERFORM ENTRADA-NOME UNTIL W-NOME <> ' '.
               PERFORM ENTRADA-SEXO UNTIL SEXO.
               PERFORM SALARIO UNTIL W-SALARIO > 0.
               PERFORM IDADE UNTIL W-IDADE > 0.
              
           ENTRADA-COD.
               ACCEPT W-COD AT 0524.
               DISPLAY EXIBE-INFO.
               
               EVALUATE W-COD
                   WHEN EQUAL 1
                       DISPLAY W-NOME AT 0813
                       DISPLAY PROF01 AT 0913
                   WHEN EQUAL 2
                       DISPLAY W-NOME AT 0813
                       DISPLAY PROF02 AT 0913
                   WHEN EQUAL 3
                       DISPLAY W-NOME AT 0813
                       DISPLAY PROF03 AT 0913
                   WHEN EQUAL 4
                       DISPLAY W-NOME AT 0813
                       DISPLAY PROF04 AT 0913
                   WHEN EQUAL 5
                       DISPLAY W-NOME AT 0813
                       DISPLAY PROF05 AT 0913
                   WHEN EQUAL 6
                       DISPLAY W-NOME AT 0813
                       DISPLAY PROF06 AT 0913
                   WHEN OTHER
                       DISPLAY CLEAR AT 0801
                       DISPLAY CLEAR AT 0901
                       DISPLAY "ERRO: COD N EXISTE" AT 0813
                  END-EVALUATE.
                 
           ENTRADA-SEXO.
               ACCEPT W-SEXO AT 0224.
           
           SALARIO.
               ACCEPT W-SALARIO-MASK at 0324.
               MOVE W-SALARIO-MASK to W-SALARIO.
       
           IDADE.
              ACCEPT W-IDADE-MASK AT 0424.
              MOVE W-IDADE-MASK TO W-IDADE.
              
           ENTRADA-NOME.
               ACCEPT W-NOME AT 0124.
               
           ERASE-VARIABLES.
               MOVE SPACES TO W-NOME.
               MOVE 0 TO W-IDADE.
               MOVE 0 TO W-SALARIO.
               MOVE 0 TO W-SALARIO-MASK.
               MOVE 0 TO W-COD.
               MOVE SPACE TO W-SEXO.
           
       END PROGRAM PROGRAM2.