@echo off
rem native application generation script
rem generates exe for windows, dmg for MacOS and rpm for Linux
rem developer Malik Tamjeed
rem 8/30/2011 

rem -- How to
rem -- remove comment key word 'rem' from each line aginst target OS
rem -- comment out every other OS by puting rem in front of each coresponding line

rem --------------------------------------------------------------------------
echo generating native QuivusOnlineClinic client:

rem --------------------------------------------------------------------------
echo for windows
@adt -package -target native QuivusOnlineClinic.exe QuivusOnlineClinic.air

rem --------------------------------------------------------------------------
rem echo for MacOS
rem @adt -package -target native QuivusOnlineClinic.dmg QuivusOnlineClinic.air

rem --------------------------------------------------------------------------
rem echo for Linux
rem @adt -package -target native QuivusOnlineClinic.rpm QuivusOnlineClinic.air

rem --------------------------------------------------------------------------
pause