C_SOURCES = $(wildcard kernel/*.c)
HEADERS = $(wildcard kernel/*.h)

# map .c file names to .o file names
OBJ = ${C_SOURCES:.c=.o}

all: os-image

# run proc
run: all
	qemu-system-x86_64 -fda os-image

# build disk image
os-image: bootstrap.bin kernel.bin
	cat $^ > $@ 

# build kernel binary
kernel.bin: kernel/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

# build C object files
%.o: %.c ${HEADERS}
	i386-elf-gcc -ffreestanding -c $< -o $@

# build kernel entry
kernel/kernel_entry.o: kernel/kernel_entry.asm 
	nasm $< -f elf -o $@

# build binaries from assembly files
bootstrap.bin: boot/bootstrap.asm
	nasm $< -f bin -I 'boot/' -o $@

clean:
	rm -rf *.bin *.dis *.o os-image
	rm -rf kernel/*.o boot/*.bin
