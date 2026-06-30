       IDENTIFICATION DIVISION.
       PROGRAM-ID. TANK-GAME.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  TANK-X            PIC 99 VALUE 10.
       01  TANK-Y            PIC 99 VALUE 10.
       01  SHELL-X           PIC 99 VALUE 0.
       01  SHELL-Y           PIC 99 VALUE 0.
       01  SHELL-ACTIVE      PIC X VALUE 'N'.
       01  SHELL-DIR         PIC X VALUE ' '.
       01  ENEMY-X           PIC 99 VALUE 20.
       01  ENEMY-Y           PIC 99 VALUE 5.
       01  ENEMY-ALIVE       PIC X VALUE 'Y'.
       01  ENEMY-HP          PIC 9 VALUE 3.
       01  SCORE             PIC 999 VALUE 0.
       01  INPUT-KEY         PIC X.
       01  ROW               PIC 99.
       01  CX                PIC 99.
       01  GAME-OVER         PIC X VALUE 'N'.
       01  ROUND-CNT         PIC 999 VALUE 0.
       01  HIT-FLAG          PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           PERFORM INIT-GAME
           PERFORM UNTIL GAME-OVER = 'Y'
               PERFORM DRAW-FIELD
               DISPLAY " "
               DISPLAY "Controls: 2=Down 8=Up 4=Left 6=Right"
               DISPLAY "           5=Shoot  0=Quit"
               DISPLAY "Enemy HP: " ENEMY-HP "  Score: " SCORE
               DISPLAY "Your move (digit): "
               ACCEPT INPUT-KEY
               PERFORM PROCESS-INPUT
               IF ENEMY-ALIVE = 'Y'
                   PERFORM MOVE-ENEMY
               END-IF
               PERFORM MOVE-SHELL
               PERFORM CHECK-HITS
               ADD 1 TO ROUND-CNT
               IF ENEMY-HP = 0
                   MOVE 'N' TO ENEMY-ALIVE
                   ADD 100 TO SCORE
                   DISPLAY "Enemy destroyed! +100 points!"
                   PERFORM SPAWN-ENEMY
               END-IF
           END-PERFORM
           DISPLAY "GAME OVER! Final Score: " SCORE
           STOP RUN.

       INIT-GAME.
           MOVE 10 TO TANK-X
           MOVE 10 TO TANK-Y
           MOVE 20 TO ENEMY-X
           MOVE 5 TO ENEMY-Y
           MOVE 3 TO ENEMY-HP
           MOVE 'Y' TO ENEMY-ALIVE
           MOVE 'N' TO GAME-OVER
           MOVE 'N' TO SHELL-ACTIVE
           MOVE 0 TO SCORE
           MOVE 0 TO ROUND-CNT.

       DRAW-FIELD.
           DISPLAY " "
           DISPLAY "+---------------------------+"
           PERFORM VARYING ROW FROM 1 BY 1 UNTIL ROW > 20
               DISPLAY "|" WITH NO ADVANCING
               PERFORM VARYING CX FROM 1 BY 1 UNTIL CX > 25
                   IF ROW = TANK-Y AND CX = TANK-X
                       DISPLAY "*" WITH NO ADVANCING
                   ELSE IF ROW = ENEMY-Y AND CX = ENEMY-X
                       IF ENEMY-ALIVE = 'Y'
                           DISPLAY "#" WITH NO ADVANCING
                       ELSE
                           DISPLAY " " WITH NO ADVANCING
                       END-IF
                   ELSE IF SHELL-ACTIVE = 'Y'
                       IF ROW = SHELL-Y AND CX = SHELL-X
                           DISPLAY "." WITH NO ADVANCING
                       ELSE
                           DISPLAY " " WITH NO ADVANCING
                       END-IF
                   ELSE
                       DISPLAY " " WITH NO ADVANCING
                   END-IF
               END-PERFORM
               DISPLAY "|"
           END-PERFORM
           DISPLAY "+---------------------------+"
           DISPLAY "* = You  # = Enemy  . = Shell".

       PROCESS-INPUT.
           EVALUATE INPUT-KEY
               WHEN '2'
                   IF TANK-Y < 20
                       ADD 1 TO TANK-Y
                   END-IF
               WHEN '8'
                   IF TANK-Y > 1
                       SUBTRACT 1 FROM TANK-Y
                   END-IF
               WHEN '4'
                   IF TANK-X > 1
                       SUBTRACT 1 FROM TANK-X
                   END-IF
               WHEN '6'
                   IF TANK-X < 25
                       ADD 1 TO TANK-X
                   END-IF
               WHEN '5'
                   IF SHELL-ACTIVE = 'N'
                       MOVE 'Y' TO SHELL-ACTIVE
                       MOVE TANK-X TO SHELL-X
                       MOVE TANK-Y TO SHELL-Y
                       MOVE 'U' TO SHELL-DIR
                   END-IF
               WHEN '0'
                   MOVE 'Y' TO GAME-OVER
               WHEN OTHER
                   DISPLAY "Invalid! Digits only (0-9)."
           END-EVALUATE.

       MOVE-SHELL.
           IF SHELL-ACTIVE = 'Y'
               EVALUATE SHELL-DIR
                   WHEN 'U'
                       IF SHELL-Y > 1
                           SUBTRACT 1 FROM SHELL-Y
                       ELSE
                           MOVE 'N' TO SHELL-ACTIVE
                       END-IF
                   WHEN 'D'
                       IF SHELL-Y < 20
                           ADD 1 TO SHELL-Y
                       ELSE
                           MOVE 'N' TO SHELL-ACTIVE
                       END-IF
                   WHEN 'L'
                       IF SHELL-X > 1
                           SUBTRACT 1 FROM SHELL-X
                       ELSE
                           MOVE 'N' TO SHELL-ACTIVE
                       END-IF
                   WHEN 'R'
                       IF SHELL-X < 25
                           ADD 1 TO SHELL-X
                       ELSE
                           MOVE 'N' TO SHELL-ACTIVE
                       END-IF
               END-EVALUATE
           END-IF.

       MOVE-ENEMY.
           EVALUATE FUNCTION MOD(ROUND-CNT, 3)
               WHEN 0
                   IF ENEMY-X > TANK-X
                       SUBTRACT 1 FROM ENEMY-X
                   ELSE IF ENEMY-X < TANK-X
                       ADD 1 TO ENEMY-X
                   END-IF
               WHEN 1
                   IF ENEMY-Y > TANK-Y
                       SUBTRACT 1 FROM ENEMY-Y
                   ELSE IF ENEMY-Y < TANK-Y
                       ADD 1 TO ENEMY-Y
                   END-IF
               WHEN 2
                   CONTINUE
           END-EVALUATE.

       CHECK-HITS.
           IF SHELL-ACTIVE = 'Y' AND ENEMY-ALIVE = 'Y'
               IF SHELL-X = ENEMY-X AND SHELL-Y = ENEMY-Y
                   MOVE 'N' TO SHELL-ACTIVE
                   SUBTRACT 1 FROM ENEMY-HP
                   ADD 10 TO SCORE
               END-IF
           END-IF
           IF ENEMY-ALIVE = 'Y'
               IF ENEMY-X = TANK-X AND ENEMY-Y = TANK-Y
                   DISPLAY "The enemy hit you!"
                   MOVE 'Y' TO GAME-OVER
               END-IF
           END-IF.

       SPAWN-ENEMY.
           MOVE 5 TO ENEMY-X
           MOVE 5 TO ENEMY-Y
           MOVE 3 TO ENEMY-HP
           MOVE 'Y' TO ENEMY-ALIVE.
