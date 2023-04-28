@echo off

set /p id=Enter date: 

echo Generating Allure Report started...
allure generate ../WebApp/report --clean --output ../Reports/%id%
