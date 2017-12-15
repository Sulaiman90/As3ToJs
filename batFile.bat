@echo off
set var=%cd%
echo %var%
powershell.exe -ExecutionPolicy Bypass -File %var%\script.ps1