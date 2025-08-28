:: Script dat de volgende stappen doorloopt:
:: 1. Log de verschillen in commits zijn tussen de %BRANCH_FROM% en %BRANCH_TO% branch.
:: 2. Log eventueel (vraag aan gebruiker) voor een overzicht aanpassingen in files
:: 3. Vraag de gebruiker of de merge van %BRANCH_FROM% naar %BRANCH_TO% mag plaatsvinden
:: 4. Voer eventueel de merge uit.

SET BRANCH_FROM=%1
SET BRANCH_TO=%2

@ECHO OFF
:start
ECHO.
ECHO Script dat de volgende stappen doorloopt:
ECHO 1. Log de verschillen in commits tussen de %BRANCH_FROM% en %BRANCH_TO% branch.
ECHO 2. Vraag de gebruiker of de merge van %BRANCH_FROM% naar %BRANCH_TO% mag plaatsvinden
ECHO 3. Doe een merge op een tijdelijke branch om het resultaat te bekijken
ECHO 4. Indien akkoord, voer een daadwerkelijke merge+push uit van de %BRANCH_FROM% branch naar de %BRANCH_TO% branch 
ECHO.
ECHO.

git checkout %BRANCH_FROM%
git pull
git checkout %BRANCH_TO%
git pull

ECHO.
ECHO Commits that are in %BRANCH_FROM% but not in %BRANCH_TO%
git log %BRANCH_TO%..%BRANCH_FROM% --no-decorate
ECHO.
ECHO Commits that are in %BRANCH_TO% but not in %BRANCH_FROM%
git log %BRANCH_FROM%..%BRANCH_TO% --no-decorate
ECHO.



SET choice1=
SET /p choice1=Wil je een overzicht van de verschillen per regel per bestand tussen %BRANCH_FROM% en %BRANCH_TO% ? [Y/N]: 
IF '%choice1%'=='Y' GOTO yes
IF '%choice1%'=='y' GOTO yes
IF '%choice1%'=='N' GOTO no
IF '%choice1%'=='n' GOTO no
IF '%choice1%'=='' GOTO no
ECHO "%choice1%" is not valid
ECHO.
GOTO start

:yes
ECHO.
ECHO.
ECHO Aanpassingen in %BRANCH_FROM% ten opzichte van %BRANCH_TO%:
git diff %BRANCH_TO%..%BRANCH_FROM%
ECHO.
ECHO.

:no
ECHO.

SET choice2=
SET /p choice2=Do you want to merge %BRANCH_FROM% into %BRANCH_TO% (we voeren eerst een dummy merge uit op een tijdelijke branch) ? [Y/N]: 
IF '%choice2%'=='Y' GOTO yes
IF '%choice2%'=='y' GOTO yes
IF '%choice2%'=='N' GOTO no
IF '%choice2%'=='n' GOTO no
IF '%choice2%'=='' GOTO no
ECHO "%choice2%" is not valid
ECHO.
GOTO start

:no
ECHO We voeren geen merge uit, einde script
PAUSE
EXIT

:yes

ECHO We maken een tijdelijke branch "%BRANCH_TO%_temp" om de merge uit te voeren en het resultaat te bekijken
ECHO.

:: Doe een merge op een tijdelijke branch (identiek aan %BRANCH_TO%) om te aanpassingen te testen
git checkout -b %BRANCH_TO%_temp %BRANCH_TO%
git merge %BRANCH_FROM%
git checkout %BRANCH_TO%
git branch -D %BRANCH_TO%_temp

ECHO.
SET choice3=
SET /p choice3= Wil je nu de daadwerkelijke merge+push uitvoeren van %BRANCH_FROM% naar %BRANCH_TO%? [Y/N]: 
IF '%choice3%'=='Y' GOTO yes
IF '%choice3%'=='y' GOTO yes
IF '%choice3%'=='N' GOTO no
IF '%choice3%'=='n' GOTO no
IF '%choice3%'=='' GOTO no
ECHO "%choice3%" is not valid
ECHO.
GOTO start

:no
ECHO We voeren geen merge uit, einde script
PAUSE

:yes

ECHO We voeren een merge+push uit van de %BRANCH_FROM% branch naar de %BRANCH_TO% branch
ECHO.

git merge %BRANCH_FROM%
git push
ECHO.
ECHO EINDE SCRIPT

PAUSE
