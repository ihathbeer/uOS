unsigned char read_port_byte(unsigned short port){
    // reads byte from specified port
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a"(result) : "d"(port));
    return result;
}

void write_port_byte(unsigned short port, unsigned char data){
    // writes given data to given port
    __asm__("out %%al, %%dx" :: "a"(data), "d"(port));
}

unsigned short read_port_word(unsigned short port){
    // reads word from specified port
    unsigned char result;
    __asm__("in %%dx, %%ax" : "=a"(result) : "d"(port));
    return result;
}

void write_port_word(unsigned short port, unsigned char data){
    // writes given word to given port
    __asm__("out %%ax, %%dx" :: "a"(data), "d"(port));
}
