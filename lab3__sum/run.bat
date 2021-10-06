@echo off

set fileName=sum
set outputFileFormat=win32

if not exist build (mkdir build)

nasm -f %outputFileFormat% %fileName%.asm -l ./build/%fileName%.lst
nasm -f %outputFileFormat% ./include/asm_io.asm

move %fileName%.obj ./build/ > nul

gcc -m32 -c ./include/driver.c -o ./include/driver.obj
gcc -m32 -o ./build/%fileName% ./build/%fileName%.obj ./include/asm_io.obj ./include/driver.obj

call "./build/%fileName%.exe"

pause > nul