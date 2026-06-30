       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULATOR.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NUM1            PIC S9(9)V99 COMP.
       01  NUM2            PIC S9(9)V99 COMP.
       01  RESULT          PIC S9(9)V99 COMP.
       01  RESULT-DISP     PIC -9(9).99.
       01  OPERATOR        PIC X.
       01  NUM1-STR        PIC X(20).
       01  NUM2-STR        PIC X(20).
       01  CONTINUE-FLAG   PIC X VALUE 'Y'.
       01  DIV-BY-ZERO     PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           PERFORM UNTIL CONTINUE-FLAG NOT = 'Y'
               DISPLAY "=============================="
               DISPLAY "   COBOL Calculator"
               DISPLAY "=============================="
               DISPLAY "Enter first number: "
               ACCEPT NUM1-STR
               COMPUTE NUM1 = FUNCTION NUMVAL(NUM1-STR)
               DISPLAY "Enter operator (+, -, *, /): "
               ACCEPT OPERATOR
               DISPLAY "Enter second number: "
               ACCEPT NUM2-STR
               COMPUTE NUM2 = FUNCTION NUMVAL(NUM2-STR)

               MOVE 'N' TO DIV-BY-ZERO

               EVALUATE OPERATOR
                   WHEN '+'
                       COMPUTE RESULT = NUM1 + NUM2
                   WHEN '-'
                       COMPUTE RESULT = NUM1 - NUM2
                   WHEN '*'
                       COMPUTE RESULT = NUM1 * NUM2
                   WHEN '/'
                       IF NUM2 = 0
                           MOVE 'Y' TO DIV-BY-ZERO
                       ELSE
                           COMPUTE RESULT = NUM1 / NUM2
                   WHEN OTHER
                       DISPLAY "Invalid operator!"
                       MOVE 'Y' TO CONTINUE-FLAG
                       MOVE ZERO TO RESULT
               END-EVALUATE

               IF DIV-BY-ZERO = 'Y'
                   DISPLAY "Error: Division by zero!"
               ELSE
                   IF OPERATOR = '+' OR '-' OR '*' OR '/'
                       MOVE RESULT TO RESULT-DISP
                       DISPLAY NUM1-STR " " OPERATOR " "
                               NUM2-STR " = " RESULT-DISP
                   END-IF
               END-IF

               DISPLAY "Continue? (Y/N): "
               ACCEPT CONTINUE-FLAG
               DISPLAY " "
           END-PERFORM

           DISPLAY "Goodbye!"
           STOP RUN.
