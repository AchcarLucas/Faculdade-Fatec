       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROGRAM1.

       ENVIRONMENT DIVISION.
           CONFIGURATION SECTION.
                SPECIAL-NAMES.
                    DECIMAL-POINT IS COMMA.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
                   SELECT ARQ-BANCO ASSIGN TO DISK
                       ORGANIZATION INDEXED
                       ACCESS MODE DYNAMIC
                       RECORD KEY IS COD-CONTA
                       ALTERNATE RECORD KEY IS CPF WITH DUPLICATES
                       FILE STATUS ARQ-OK.

       DATA DIVISION.
       
           FILE SECTION.
               FD ARQ-BANCO LABEL RECORDS STANDARD VALUE OF FILE-ID IS "ARQ-BANCO.DAT".
               
                01   REG-BANCO.
                    02  REG-INDEX               PIC 99.
                    02  CPF                     PIC 99999999999.
                    02  COD-AGENCIA             PIC 9(4).
                    02  COD-CONTA               PIC 9(7).
                    02  W-NOME                  PIC X(32).
                    02  W-SALDO                 PIC ZZZZZZZZ9.99.
                    02  W-LIMITE                PIC ZZZZZZZZ9.99.
                    
                01  REG-CHECK.
                    02  ARQ-OK              PIC 9(2).
                    
       
       WORKING-STORAGE SECTION.
       
       
                01 GLOBAL-VARIABLES.
                    02  W-OPTION        PIC X(2).
                        88 OPTIONS  VALUE '01', '02', '03', '04', '05'.
                    02 W-COUNT          PIC 9(4).
                    
                    02 W-ASK            PIC X(1) VALUE SPACE.
                       88 S-ASK      VALUE 'S' 's'.
                       88 N-ASK      VALUE 'N' 'n'.
                        
                01 MASK-VARIABLES.
                    02  M-CPF               PIC 999.999.999.99.
                    02  W-CPF               PIC 99999999999.
                    02  M-COD-CONTA         PIC 99999.99.
                    02  W-COD-CONTA         PIC 9999999.
                    
                01 CPF-VERIFICATION.
                    02  W-CPF-DIGIT                 PIC 9       VALUE ZEROS.
                    02  W-CPF-SUM                   PIC 999999  VALUE ZEROS.
                    02  W-CPF-FACTOR                PIC 99      VALUE ZEROS.
                    02  W-TMP                       PIC 999999  VALUE ZEROS.
                    02  W-REMAINDER                 PIC 999999  VALUE ZEROS.
                    02  W-FIRST-DIGIT               PIC 9       VALUE ZEROS.
                    02  W-SECOND-DIGIT              PIC 9       VALUE ZEROS.
       
                01 DATE-TIME.
			        02 YEARS		PIC 9(02).
			        02 MONTHS		PIC 9(02).
			        02 DAYS			PIC 9(02).
       
                01  MSG-ERRORS.
                    02  MSG-ERROR-01        VALUES      "OCORREU UM ERRO AO TENTAR GRAVAR O REGISTRO       ".
                    02  MSG-ERROR-02        VALUES      "OCORREU UM ERRO AO TENTAR LER O REGISTRO          ".
                    02  MSG-ERROR-03        VALUES      "OCORREU UM ERRO AO TENTAR APAGAR O REGISTRO       ".
                    02  MSG-ERROR-04        VALUES      "OCORREU UM ERRO AO TENTAR MODIFICAR O REGISTRO    ".
                    02  MSG-ERROR-05        VALUES      "INVALID OPTION                                    ".
                    02  MSG-ERROR-06        VALUES      "O CPF DIGITADO E´ INVALIDO                        ".
                    02  MSG-ERROR-07        VALUES      "CONTA NÂO ENCONTRADO NA BASE DE DADOS             ".
                    02  MSG-ERROR-08        VALUES      "CONTA JA CONSTA NA BASE DE DADOS                  ".
                    02  MSG-ERROR-09        VALUES      "CONTA DEVE SER DIFERENTE DE 00000.00              ".
                    02  MSG-ERROR-10        VALUES      "O NOME E OBRIGATORIO                              ".
                    02  MSG-ERROR-11        VALUES      "AGENCIA DEVE SER DIFERENTE DE 0000                ".
                    02  MSG-ERROR-BLANK     VALUES      "---                                               ".
                    
                01 MSG-COMMON.
                    02 MSG01            VALUES  "DESEJA CONTINUAR <S/N>: ".
                    02 MSG02            VALUES  "CONTA CRIADA COM SUCESSO                                  ".
                    02 MSG03            VALUES  "CONTA APAGADA COM SUCESSO                                 ".
                    02 MSG04            VALUES  "CONTA MODIFICADA COM SUCESSO                              ".

       SCREEN SECTION.
       
            01  MAIN-SCREEN.
                02 LINE 01 COLUMN 05 PIC 9(02)/ USING DAYS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 08 PIC 9(02)/ USING MONTHS FOREGROUND-COLOR IS 2.
	            02 LINE 01 COLUMN 11 PIC 9(02) USING YEARS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 20 VALUES "MENU PRINCIPAL" FOREGROUND-COLOR IS 2.
                02 LINE 03 COLUMN 05 VALUES "01  -    CRIAR CONTA" FOREGROUND-COLOR IS 7.
                02 LINE 05 COLUMN 05 VALUES "02  -  CONSULTAR CONTA" FOREGROUND-COLOR IS 7.
                02 LINE 07 COLUMN 05 VALUES "03  -   DELETAR CONTA" FOREGROUND-COLOR IS 7.
                02 LINE 09 COLUMN 05 VALUES "04  -  MODIFICAR CONTA" FOREGROUND-COLOR IS 7.
                02 LINE 11 COLUMN 05 VALUES "05  -       SAIR" FOREGROUND-COLOR IS 7.
                02 LINE 13 COLUMN 05 VALUES "OPTION: " FOREGROUND-COLOR IS 2.
                02 LINE 20 COLUMN 05 VALUES "STATUS: ---" FOREGROUND-COLOR IS 2.
                
           01   SEARCH-SCREEN.
                02 LINE 01 COLUMN 05 PIC 9(02)/ USING DAYS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 08 PIC 9(02)/ USING MONTHS FOREGROUND-COLOR IS 2.
	            02 LINE 01 COLUMN 11 PIC 9(02) USING YEARS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 20 VALUES "CONSULTAR CONTA" FOREGROUND-COLOR IS 2.
                02 LINE 03 COLUMN 05 VALUES "CONTA: " FOREGROUND-COLOR IS 2.
                02 LINE 05 COLUMN 05 VALUES "NOME    : ".
                02 LINE 06 COLUMN 05 VALUES "CPF     : ".
                02 LINE 08 COLUMN 05 VALUES "CONTA   : ".
                02 LINE 09 COLUMN 05 VALUES "AGENCIA : ".
                02 LINE 10 COLUMN 05 VALUES "SALDO   : ".
                02 LINE 11 COLUMN 05 VALUES "LIMITE  : ".
                02 LINE 20 COLUMN 05 VALUES "STATUS: ---" FOREGROUND-COLOR IS 2.
                
            01  CREATE-SCREEN.
                02 LINE 01 COLUMN 05 PIC 9(02)/ USING DAYS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 08 PIC 9(02)/ USING MONTHS FOREGROUND-COLOR IS 2.
	            02 LINE 01 COLUMN 11 PIC 9(02) USING YEARS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 20 VALUES "CRIAR CONTA" FOREGROUND-COLOR IS 2.
                02 LINE 03 COLUMN 05 VALUES "CPF: " FOREGROUND-COLOR IS 2.
                02 LINE 05 COLUMN 05 VALUES "NOME    : ".
                02 LINE 07 COLUMN 05 VALUES "CONTA   : ".
                02 LINE 08 COLUMN 05 VALUES "AGENCIA : ".
                02 LINE 09 COLUMN 05 VALUES "SALDO   : ".
                02 LINE 10 COLUMN 05 VALUES "LIMITE  : ".
                02 LINE 20 COLUMN 05 VALUES "STATUS: ---" FOREGROUND-COLOR IS 2.
                
            01  DELETE-SCREEN.
                02 LINE 01 COLUMN 05 PIC 9(02)/ USING DAYS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 08 PIC 9(02)/ USING MONTHS FOREGROUND-COLOR IS 2.
	            02 LINE 01 COLUMN 11 PIC 9(02) USING YEARS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 20 VALUES "DELETAR CONTA" FOREGROUND-COLOR IS 2.
                02 LINE 05 COLUMN 05 VALUES "CONTA   : " FOREGROUND-COLOR IS 2.
                02 LINE 20 COLUMN 05 VALUES "STATUS: ---" FOREGROUND-COLOR IS 2.
                
           01  MODIFY-SCREEN.
                02 LINE 01 COLUMN 05 PIC 9(02)/ USING DAYS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 08 PIC 9(02)/ USING MONTHS FOREGROUND-COLOR IS 2.
	            02 LINE 01 COLUMN 11 PIC 9(02) USING YEARS FOREGROUND-COLOR IS 2.
                02 LINE 01 COLUMN 20 VALUES "MODIFICAR CONTA" FOREGROUND-COLOR IS 2.
                02 LINE 05 COLUMN 05 VALUES "CONTA   : " FOREGROUND-COLOR IS 2.
                02 LINE 20 COLUMN 05 VALUES "STATUS: ---" FOREGROUND-COLOR IS 2.
                
          01 MODIFY-SCREEN-COMPLEMENT.
                02 LINE 07 COLUMN 05 VALUES "CPF     :".
                02 LINE 08 COLUMN 05 VALUES "NOME    :".
                02 LINE 09 COLUMN 05 VALUES "SALDO   :".
                02 LINE 10 COLUMN 05 VALUES "LIMITE  :".
                
            01  CLEAR-SCREEN.
                02  BLANK SCREEN.

       PROCEDURE DIVISION.

            INIT.
                PERFORM OPEN-FILE.
                *> OPÇÂO 05 FIM DO PROGRAMA
                PERFORM LOOP-MAIN UNTIL W-OPTION EQUAL '05'.
                PERFORM END-PROGRAM.
                
            *> LOOP DA TELA PRINCIPAL
            LOOP-MAIN.
                ACCEPT DATE-TIME FROM DATE.
                DISPLAY CLEAR-SCREEN.
                DISPLAY MAIN-SCREEN.
                
                MOVE SPACES TO W-OPTION.
                MOVE SPACES TO W-ASK.
                
                PERFORM MAIN-SCREEN-OPTION UNTIL OPTIONS.
                
                EVALUATE W-OPTION
                    WHEN EQUAL '01'
                        *> PERFORM LOOP SCREEN CREATE
                        PERFORM LOOP-CREATE UNTIL N-ASK
                    WHEN EQUAL '02'
                        *> PERFORM LOOP SCREEN SEARCH
                        PERFORM LOOP-SEARCH UNTIL N-ASK
                    WHEN EQUAL '03'
                        *> PERFORM LOOP SCREEN DELETE
                        PERFORM LOOP-DELETE UNTIL N-ASK
                    WHEN EQUAL '04'
                        *> PERFORM LOOP SCREEN MODIFY
                        PERFORM LOOP-MODIFY UNTIL N-ASK
                END-EVALUATE.
                
            *> MENU TELA PRINCIPAL
            MAIN-SCREEN-OPTION.
                ACCEPT W-OPTION AT 1313 WITH PROMPT AUTO.
                IF IS NOT OPTIONS
                    DISPLAY MSG-ERROR-05 AT 2013 FOREGROUND-COLOR IS 4
                END-IF.
                
                
            *> CONSULTAR CONTA
            LOOP-SEARCH.
                PERFORM EMPTY-REG.
                ACCEPT DATE-TIME FROM DATE.
                DISPLAY CLEAR-SCREEN.
                DISPLAY SEARCH-SCREEN.
                
                MOVE SPACES TO W-ASK.
                MOVE SPACES TO M-COD-CONTA.
                
                ACCEPT M-COD-CONTA at 0312.
                MOVE M-COD-CONTA TO COD-CONTA.
                PERFORM ERROR-BLANK.
                
                IF COD-CONTA NOT EQUAL ZEROS
                    PERFORM READ-REG
                    *> VERIFICA SE O DADO EXISTE 23 = NÂO CONSTA NA BASE DE DADOS.
                    IF ARQ-OK EQUAL '23'
                        DISPLAY MSG-ERROR-07 AT 2013
                    ELSE
                        *> CONSULTA FEITA COM SUCESSO ...
                        DISPLAY W-NOME at 0515
                        MOVE CPF TO M-CPF
                        DISPLAY M-CPF at 0615
                        MOVE COD-CONTA TO M-COD-CONTA
                        DISPLAY M-COD-CONTA at 0815
                        DISPLAY COD-AGENCIA at 0915
                        DISPLAY W-SALDO at 1015
                        DISPLAY W-LIMITE at 1115
                    END-IF
                END-IF.
                
                *> PERGUNTA SE DESEJA SAIR OU NÂO ...
                PERFORM CALL-ASK UNTIL S-ASK OR N-ASK.
                
            SEARCH-CHECK-CPF.
                ACCEPT M-CPF AT 0310 WITH PROMPT.
                MOVE M-CPF TO W-CPF.
                PERFORM ALGORTHM-CPF-VERIFICATE.
                IF (W-CPF(10:1) NOT EQUAL W-FIRST-DIGIT OR W-CPF(11:1) NOT EQUAL W-SECOND-DIGIT) AND W-CPF-SUM NOT EQUAL 2
                    DISPLAY MSG-ERROR-06 AT 2013 FOREGROUND-COLOR IS 4
                END-IF.
                
            MODIFY-CHECK-CPF.
                ACCEPT M-CPF AT 0715 WITH PROMPT.
                MOVE M-CPF TO W-CPF.
                PERFORM ALGORTHM-CPF-VERIFICATE.
                IF (W-CPF(10:1) NOT EQUAL W-FIRST-DIGIT OR W-CPF(11:1) NOT EQUAL W-SECOND-DIGIT) AND W-CPF-SUM NOT EQUAL 2
                    DISPLAY MSG-ERROR-06 AT 2013 FOREGROUND-COLOR IS 4
                END-IF.
                
            *> CRIAR CONTA
            LOOP-CREATE.
                PERFORM EMPTY-REG.
                ACCEPT DATE-TIME FROM DATE.
                DISPLAY CLEAR-SCREEN.
                DISPLAY CREATE-SCREEN.
                
                MOVE SPACE TO W-ASK.
                MOVE SPACES TO M-CPF.
                
                PERFORM SEARCH-CHECK-CPF TEST AFTER UNTIL W-CPF(10:1) EQUAL W-FIRST-DIGIT AND W-CPF(11:1) EQUAL W-SECOND-DIGIT OR W-CPF-SUM EQUAL 2.
                PERFORM ERROR-BLANK.
                
                *> VERIFICA SE O CPF NÂO È TUDO 000.000.000.00, SE FOR, PERGUNTA SE DESEJA CONTINUAR NA TELA
                IF W-CPF-SUM NOT EQUAL 2
                    MOVE W-CPF TO CPF
                    PERFORM CHECK-NOME-CREATE UNTIL W-NOME NOT EQUAL SPACES
                    PERFORM ERROR-BLANK
                    
                    MOVE ZEROS TO COD-CONTA
                    MOVE ZEROS TO M-COD-CONTA
                    PERFORM CHECK-COD-CONTA UNTIL COD-CONTA > 0
                    PERFORM ERROR-BLANK
                    
                    MOVE ZEROS TO COD-AGENCIA
                    PERFORM CHECK-COD-AGENCIA UNTIL COD-AGENCIA > 0
                    PERFORM ERROR-BLANK
                    
                    ACCEPT W-SALDO AT 0915
                    ACCEPT W-LIMITE AT 1015
                    PERFORM WRITE-REG
                    *> CONTA JÀ EXISTE ? 22 = CHAVE DUPLICADA
                    IF ARQ-OK EQUAL '22'
                        DISPLAY MSG-ERROR-08 AT 2013
                    ELSE
                        DISPLAY MSG02 AT 2013 FOREGROUND-COLOR IS 2
                    END-IF
                END-IF.
                
                *> PERGUNTA SE DESEJA SAIR OU NÂO ...
                PERFORM CALL-ASK UNTIL S-ASK OR N-ASK.
             
            *> DELETAR CONTA LOOP
            LOOP-DELETE.
                PERFORM EMPTY-REG.
                ACCEPT DATE-TIME FROM DATE.
                DISPLAY CLEAR-SCREEN.
                DISPLAY DELETE-SCREEN.
                
                MOVE SPACE TO W-ASK.
                *> RECEBE A CONTA
                ACCEPT M-COD-CONTA AT 0515.
                MOVE M-COD-CONTA TO COD-CONTA.
                
                *> VERIFICA SE A CONTA È DIFERENTE DE ZERO (00000.00), SE SIM, PROCURA E TENTA APAGAR
                IF COD-CONTA NOT EQUAL ZEROS
                    PERFORM DELETE-REG
                    *> VERIFICA SE ENCONTROU E APAGOU
                    IF ARQ-OK EQUAL 23
                        *> NÂO ENCONTRADO NA BASE DE DADOS ....
                        DISPLAY MSG-ERROR-07 AT 2013 FOREGROUND-COLOR IS 4
                    ELSE
                        *> MENSAGEM DE APAGADO COM SUCESSO ....
                        DISPLAY MSG03 AT 2013 FOREGROUND-COLOR IS 2
                    END-IF
                END-IF.
                
                *> PERGUNTA SE DESEJA SAIR OU NÂO ...
                PERFORM CALL-ASK UNTIL S-ASK OR N-ASK.
                
            *> DELETAR CONTA LOOP
            LOOP-MODIFY.
                PERFORM EMPTY-REG.
                ACCEPT DATE-TIME FROM DATE.
                DISPLAY CLEAR-SCREEN.
                DISPLAY MODIFY-SCREEN.
                
                MOVE SPACE TO W-ASK.
                *> RECEBE A CONTA
                ACCEPT M-COD-CONTA AT 0515.
                MOVE M-COD-CONTA TO COD-CONTA.
                
                *> VERIFICA SE A CONTA È DIFERENTE DE ZERO (00000.00), SE SIM, PROCURA E TENTA APAGAR
                IF COD-CONTA NOT EQUAL ZEROS
                    PERFORM READ-REG
                    *> VERIFICA 23 = NÂO CONSTA NA BASE DE DADOS
                    IF ARQ-OK EQUAL 23
                        *> NÂO ENCONTRADO NA BASE DE DADOS ....
                        DISPLAY MSG-ERROR-07 AT 2013 FOREGROUND-COLOR IS 4
                    ELSE
                        *> SE TIVER AQUI SIGNIFICA QUE A CONTA EXISTE ...
                        
                        *> MOSTRA O COMPLETOMENTO DA TELA
                        DISPLAY MODIFY-SCREEN-COMPLEMENT
                        
                        *> COLOCA O CPF NA MASCARA E DEPOIS CHAMA A FUNÇÂO PARA LER E VERIFICAR O CPF ...
                        MOVE CPF TO M-CPF
                        PERFORM MODIFY-CHECK-CPF TEST AFTER UNTIL W-CPF(10:1) EQUAL W-FIRST-DIGIT AND W-CPF(11:1) EQUAL W-SECOND-DIGIT
                        PERFORM ERROR-BLANK
                        MOVE M-CPF TO CPF
                        
                        PERFORM CHECK-NOME-MODIFY TEST AFTER UNTIL W-NOME NOT EQUAL SPACES
                        
                        ACCEPT W-SALDO AT 0915
                        ACCEPT W-LIMITE AT 1015
                        
                        *> SALVA E EXIBE MENSAGEM ....
                        PERFORM MODIFY-REG
                        DISPLAY MSG04 AT 2013 FOREGROUND-COLOR IS 2
                        
                    END-IF
                END-IF.
                
                *> PERGUNTA SE DESEJA SAIR OU NÂO ...
                PERFORM CALL-ASK UNTIL S-ASK OR N-ASK.
                
            *> VERIFICA O NOME DIGITADO, DEVE SER DIFERENTE DE ESPAÇO
            CHECK-NOME-CREATE.
                ACCEPT W-NOME AT 0515 WITH PROMPT.
                IF W-NOME EQUAL SPACES
                    DISPLAY MSG-ERROR-10 AT 2013 FOREGROUND-COLOR IS 4
                END-IF.
                
           CHECK-NOME-MODIFY.
                ACCEPT W-NOME AT 0815 WITH PROMPT.
                IF W-NOME EQUAL SPACES
                    DISPLAY MSG-ERROR-10 AT 2013 FOREGROUND-COLOR IS 4
                END-IF.
            
            *> VERIFICA O COD DA CONTA, DEVE SER MAIOR QUE ZERO
            CHECK-COD-CONTA.
                ACCEPT M-COD-CONTA AT 0715 WITH PROMPT.
                MOVE M-COD-CONTA to COD-CONTA.
                IF COD-CONTA EQUAL 0
                    DISPLAY MSG-ERROR-09 AT 2013 FOREGROUND-COLOR IS 4
                END-IF.
                
            *> VERIFICA O COD DA CONTA, DEVE SER MAIOR QUE ZERO
            CHECK-COD-AGENCIA.
                ACCEPT COD-AGENCIA AT 0815 WITH PROMPT.
                IF COD-AGENCIA EQUAL 0
                    DISPLAY MSG-ERROR-11 AT 2013 FOREGROUND-COLOR IS 4
                END-IF.
                
            ALGORTHM-CPF-VERIFICATE.
                MOVE 1 TO W-COUNT.
                MOVE ZEROS TO W-CPF-SUM.
                MOVE 10 TO W-CPF-FACTOR.
                MOVE ZEROS TO W-REMAINDER.
                MOVE ZEROS TO W-TMP.
                
                *> PRIMEIRA PARTE DO ALGORTHM (PRIMEIRO DIGITO VERIFICADOR)
                PERFORM SUM-ALGORTHM-CPF-VERIFICATE UNTIL W-COUNT EQUAL 10.
                DIVIDE W-CPF-SUM by 11 GIVING W-TMP REMAINDER W-REMAINDER.
                
                IF W-REMAINDER EQUAL 10 OR  W-REMAINDER EQUAL 11
                    MOVE 0 TO W-FIRST-DIGIT
                ELSE
                    SUBTRACT 11 FROM W-REMAINDER GIVING W-FIRST-DIGIT
                END-IF.
               
                *> SEGUNDA PARTE DO ALGORTHM (SECUNDO DIGITO VERIFICADOR)
                MOVE 1 TO W-COUNT.
                MOVE ZEROS TO W-CPF-SUM.
                MOVE 11 TO W-CPF-FACTOR.
                MOVE ZEROS TO W-REMAINDER.
                MOVE ZEROS TO W-TMP.
                
                PERFORM SUM-ALGORTHM-CPF-VERIFICATE UNTIL W-COUNT EQUAL 10.
                MULTIPLY 2 BY W-FIRST-DIGIT GIVING W-TMP.
                ADD W-TMP TO W-CPF-SUM GIVING W-CPF-SUM.
                
                DIVIDE W-CPF-SUM BY 11 GIVING W-TMP REMAINDER W-REMAINDER.
                
                IF W-REMAINDER EQUAL 10 OR  W-REMAINDER EQUAL 11
                    MOVE 0 TO W-SECOND-DIGIT
                ELSE
                    SUBTRACT 11 FROM W-REMAINDER GIVING W-SECOND-DIGIT
                END-IF.
            
            *> ALGORTHM VERIFICAÇÂO DO CPF
            SUM-ALGORTHM-CPF-VERIFICATE.
                MOVE W-CPF(W-COUNT:1) TO W-CPF-DIGIT.
                MULTIPLY W-CPF-DIGIT BY W-CPF-FACTOR GIVING W-TMP.
                ADD W-TMP TO W-CPF-SUM GIVING W-CPF-SUM.
                ADD 1 TO W-COUNT.
                SUBTRACT 1 FROM W-CPF-FACTOR.
            
            
            *> PROCEDURES PARA FILE MANIPULATE
            OPEN-FILE.
                OPEN I-O ARQ-BANCO.
            
            WRITE-REG.
                WRITE REG-BANCO INVALID KEY PERFORM FILE-ERROR-WRITE.
                
            READ-REG.
                READ ARQ-BANCO invalid key perform FILE-ERROR-READ.
                
            DELETE-REG.
                DELETE ARQ-BANCO INVALID KEY PERFORM FILE-ERROR-DELETE.
                
            MODIFY-REG.
                REWRITE REG-BANCO INVALID KEY PERFORM FILE-ERROR-MODIFY.
                
            *> *********************************************
            
            *> MENSAGENS DE ERROS
            FILE-ERROR-WRITE.
                DISPLAY MSG-ERROR-01 AT 2013 FOREGROUND-COLOR IS 4.
            
            FILE-ERROR-READ.
                DISPLAY MSG-ERROR-02 AT 2013 FOREGROUND-COLOR IS 4.
                
            FILE-ERROR-DELETE.
                DISPLAY MSG-ERROR-03 AT 2013 FOREGROUND-COLOR IS 4.
                
            FILE-ERROR-MODIFY.
                DISPLAY MSG-ERROR-04 AT 2013 FOREGROUND-COLOR IS 4.
                
            ERROR-BLANK.
                DISPLAY MSG-ERROR-BLANK AT 2013 FOREGROUND-COLOR IS 2.
                
            *> *********************************************
            
            *> LIMPA A TELA
            CLEAN-SCREEN.
                DISPLAY CLEAR-SCREEN AT 0101.
            
            *> PROCEDURE PARA O FIM DO PROGRAAM
            END-PROGRAM.
                PERFORM CLEAN-SCREEN.
                STOP "FIM DO PROGRAMA".
                STOP RUN.
                
           *> PROCEDIMENTO DE PERGUNTA SE DESEJA FICAR NA TELA OU NÂO, UTILIZADO EM VÀRIAS TELAS ...
           CALL-ASK.
                MOVE SPACES TO W-ASK.
                DISPLAY MSG01 at 2505.
                ACCEPT W-ASK AT 2529 WITH PROMPT AUTO.
                IF NOT S-ASK OR NOT N-ASK
                    DISPLAY MSG-ERROR-05 AT 2013 FOREGROUND-COLOR IS 4
                END-IF.
               
           *> LIMPA O REGISTRO
           EMPTY-REG.
                MOVE ZEROS TO CPF.
                MOVE ZEROS TO W-LIMITE.
                MOVE ZEROS TO W-SALDO.
                MOVE SPACES TO W-NOME.
                MOVE ZEROS TO COD-AGENCIA.
                MOVE ZEROS TO M-COD-CONTA.
                MOVE ZEROS TO COD-CONTA.

       END PROGRAM PROGRAM1.