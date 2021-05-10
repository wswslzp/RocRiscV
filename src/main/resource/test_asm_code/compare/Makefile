CXX_COMPILER:=riscv64-unknown-elf-as
OBJCOPIER:=riscv64-unknown-elf-objcopy
OBJDUMPER:=riscv64-unknown-elf-objdump

all: *.s 
	${CXX_COMPILER} -march=rv64i -mabi=lp64 -o main *.s
	${OBJCOPIER} -O ihex main main.hex
	${OBJDUMPER} -d main -M no-aliases,numeric > main.d