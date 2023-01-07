OUT=../shim.exe
CC=x86_64-w64-mingw32-gcc

CFLAGS?=-O2 -Wall
LDFLAGS?=-s -static-libgcc

$(OUT): main.c
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
