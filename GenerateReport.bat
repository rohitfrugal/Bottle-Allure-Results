@echo off

set "sourceDir=E:\POM_for_Bottle\Reports"
set "destinationDir=E:\POM_for_Bottle\report"
set "folderName=history"

REM Find the latest folder (excluding ".git" directory)
for /F "delims=" %%d in ('dir /B /AD /O-D "%sourceDir%\*" ^| findstr /V /C:".git"') do (
    set "latestFolder=%%d"
    goto :CopyFolder
)

:CopyFolder
REM Check if the latest folder exists
if not exist "%sourceDir%\%latestFolder%" (
    echo Latest folder does not exist.
    exit /b
)

REM Check if the folder to copy exists in the latest folder
if not exist "%sourceDir%\%latestFolder%\%folderName%" (
    echo Folder to copy does not exist in the latest folder.
    exit /b
)

REM Create a new "history" folder in the destination directory
set "historyDir=%destinationDir%\history"
mkdir "%historyDir%" 2>nul

REM Copy the folder to the "history" folder
xcopy "%sourceDir%\%latestFolder%\%folderName%" "%historyDir%" /E /I /H /Y

echo Folder copied successfully to the history folder.

set /p id=Enter date:

echo Generating Allure Report started...
allure generate ../report --clean --output ../Reports/%id%
