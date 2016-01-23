del /s /q "*.ali"
del /s /q "*.o"
del /s /q "*.exe"

gprbuild -Pmain.gpr -Xmode=release

cd bin
::main_test.exe
main.exe
pause
