CXX_COMPILER:=riscv64-unknown-elf-gcc
OBJCOPIER:=riscv64-unknown-elf-objcopy
OBJDUMPER:=riscv64-unknown-elf-objdump

all: *.c 
	${CXX_COMPILER} -march=rv64i -mabi=lp64 -o main *.c
	${OBJCOPIER} -O ihex main main.hex
	${OBJDUMPER} -d main -M no-aliases,numeric > main.d