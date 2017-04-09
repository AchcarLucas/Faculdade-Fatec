       identification division.
       program-id. Program1.

       environment division.
           configuration section.

       data division.
           working-storage section.
               01 AREA-TRABALHO.
                   02 WS-NOME          PIC X(30).
                   02 WS-CONTADOR      PIC 9(03).
                   02 WS-NUMERO        PIC 9(02).
                   02 WS-RESULTADO     PIC 9(07).
                   02 WS-CONTINUE      PIC X(01) VALUE SPACE.
                       88 CONT VALUE 'N' 'n' 'S' 's'.
                   02 WS-FL            PIC 9(01) VALUE ZEROS.
               01 MENSAGENS-DE-TELA.
                   02 MSG01            PIC X(30) VALUE 
                   "NUMERO DEVE SER MENOR QUE 10".
                   02 MSG02            PIC X(30) VALUE 
                   "FIM DO PROGRAMA".
                   02 MSG03            PIC X(30) VALUE SPACE.
               01 DATA-DO-SISTEMA
                   02 ANO              PIC 9(02).
                   02 MES              PIC 9(02).
                   02 DIA              PIC 9(02).
           screen section.
               01 TELA01.
                   02 BLANK SCREEN.
                   02 LINE 02 COLUMN 05    PIC 9(02)/ USING DIA.
                   02 LINE 02 COLUMN 08    PIC 9(02)/ USING MES.
                   02 LINE 02 COLUMN 11    PIC 9(02) USING ANO.
                   02 LINE 02 COLUMN 28    VALUE 
                   "CALCULO DE FATORIAL".
                   02 LINE 08 COLUMN 21    VALUE 
                   "NOME: ".
                   02 LINE 12 COLUMN 21    VALUE 
                   "NUMERO: ".
                   02 LINE 14 COLUMN 21    VALUE "FATORIAL: ".
                   02 LINE 16 COLUMN 10    VALUE "CONTINUA (S/N): ".

       procedure division.
           INICIO.
               accept DATA-DO-SISTEMA from date.
               perform PROCESSO until CONT
               perform SAIDA.
               stop run.
               
           PROCESSO.
               perform TELA.
               move zeros to WS-FL.
               perform ENTRA-DADOS until WS-FL = 1.
               perform CALCULA until WS-CONTADOR > WS-NUMERO.
               perform RESULTADO until CONT.
               exit.
               
               
           TELA.
               display erase at 0101.
               display TELA01 at 0101.
               move 2 to WS-CONTADOR.
               move zeros to WS-NUMERO.
               move 1 to WS-RESULTADO.
               exit.
               
           ENTRA-DADOS.
               accept WS-NOME at 0832 with prompt auto.
               accept WS-NUMERO at 1232 with prompt auto.
               *>if WS-NUMERO > 10
               *>    display MSG01 at 2310
               *>else
               *>    display MSG03 at 2310
               *>    move 1 to WS-FL
               *>end-if.
               display MSG03 at 2310.
               move 1 to WS-FL.
               exit.
               
           CALCULA.
               compute WS-RESULTADO = WS-RESULTADO * WS-CONTADOR.
               add 1 to WS-CONTADOR.
               exit.
       
           RESULTADO.
               display WS-RESULTADO at 1432.
               accept WS-CONTINUE at 1628 with prompt auto.
               exit.
               
           SAIDA.
               display erase at 0101.
               display MSG02.
               stop " ".
               exit.
 
       end program Program1.
       
       *> Programa 6 Exercicio
       *> 1) O que este programa não trata? 
       *> R) O programa não trata o nome.
       *> 2)Faça o mesmo programa anterior, mas aceitando qualquer valor
       *> para variável  WS-NUMERO
       *> R) FEITO...