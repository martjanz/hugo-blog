REM MESSAGE: mensaje de commit (opcional).
REM HUGO_DIR: path de hugo.exe.

REM Ejemplo: deploy.bat --message "Va un commit" --hugo-path C:\Portables\Hugo

@ECHO OFF
ECHO Compiling static site...
ECHO.

REM clean variables
SET message=
SET hugo_path=
SET DATETIME=


REM Assumes ES-AR style date format for date environment variable (DD/MM/YYYY).
REM Assumes times before 10:00:00 (10am) displayed padded with a space instead of a zero.
REM If first character of time is a space (less than 1) then set DATETIME to:
REM YYYY-MM-DD-0h-mm-ss
REM Otherwise, set DATETIME to:
REM YYYY-MM-DD-HH-mm-ss
REM Year, month, day format provides better filename sorting (otherwise, days grouped
REM together when sorted alphabetically).

IF "%time:~0,1%" LSS "1" (
   SET DATETIME=%date:~6,4%-%date:~3,2%-%date:~0,2%-0%time:~1,1%-%time:~3,2%-%time:~6,2%
) ELSE (
   SET DATETIME=%date:~6,4%-%date:~3,2%-%date:~0,2%-%time:~0,2%-%time:~3,2%-%time:~6,2%
)

:loop
IF NOT "%1"=="" (
    IF "%1"=="--message" (
        SET message=%2
        SHIFT
    )
    IF "%1"=="--hugo-path" (
        SET hugo_path=%2
        SHIFT
    )
    SHIFT
    GOTO :loop
)

if "%hugo_path%"=="" (
    SET hugo_exe=hugo.exe
) else (
    SET hugo_exe=%hugo_path%\hugo.exe
)

if not exist %hugo_exe% (
    echo ERROR: Hugo executable not found. Check --hugo-path parameter.
    EXIT /b
)


ECHO Building site...
REM If using a theme replace by `hugo -t <yourtheme> or add <yourtheme> to config file
%hugo_exe%

REM Go to public folder.
CD public

ECHO Deploying updates to GitHub...
ECHO.

REM Add all changes to git.
git add --all

REM Commit changes.

if [%message%]==[] (
    SET message = "Rebuilding site on %DATETIME"
)

git commit -m %message%

REM Push source and build repos.
git push origin master

REM Go back to previous folder.
cd ..