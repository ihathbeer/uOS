#include "screen.h"
#include "low_level.h"

int get_screen_offset(int col, int row){
	// calculate offset from col & row
	return (MAX_COLS * row + col) * 2;
}

int get_cursor(){
	// register 14 = hi byte of offset; 
	write_port_byte(REG_SCREEN_CTRL, 14);
	int offset = read_port_byte(REG_SCREEN_DATA) << 8;
	// register 15 = low byte of offset
	write_port_byte(REG_SCREEN_CTRL, 15);
	offset += read_port_byte(REG_SCREEN_DATA);
	// convert char offset -> memory offset
	return offset*2;
}

void set_cursor(int offset){
	// memory offset -> character offset
	offset /= 2;
	
	// write hi byte of offset
	write_port_byte(REG_SCREEN_CTRL, 14);
	write_port_byte(REG_SCREEN_DATA, (unsigned char) (offset >> 8));
	// write low byte of offset
	write_port_byte(REG_SCREEN_CTRL, 15);
	write_port_byte(REG_SCREEN_DATA, (unsigned char) (offset & 0xff));
}

void print_char(char chr, int col, int row, char attr_byte){
	unsigned char* video_mem = (unsigned char*) VIDEO_ADDRESS;

	// resort to default if NULL
	if(!attr_byte){
		attr_byte = WHITE_ON_BLACK;
	}

	int offset;

	// determine offset from col & row if they're provided
	if(col >= 0 && row >= 0){
		offset = get_screen_offset(col, row);
	}else{
		offset = get_cursor();
	}

	if(chr == '\n'){
		// to be implemented
	}

	// write to vid memory
	*(video_mem + offset) = chr;
	*(video_mem + offset + 1) = attr_byte;

	offset += 2;
	// offset = handle_scrolling(offset);

	set_cursor(offset);
}

void print_at(char* msg, int col, int row){
	// set cursor if col & row were provided
	if(col >= 0 && row >= 0){
		set_cursor(get_screen_offset(col, row));
	}

	// print msg one chr at a time
	int k = 0;

	while(msg[k] != 0) 
		print_char(msg[k++], col, row, WHITE_ON_BLACK);
}

void print(char* msg){
	// print msg at current cursor position
	print_at(msg, -1, -1);
}

void cls(){
	// determine size of screen to clear
	int size = MAX_COLS * MAX_ROWS;
	// define index
	int i;
	// make up pt to vid mem
	unsigned char* video_mem = (unsigned char*) VIDEO_ADDRESS;

	// write space to each 2 byte vid mem location
	for(i = 0; i < size; i++){
		*(video_mem + i * 2) = ' ';
		*(video_mem + i * 2 + 1) = WHITE_ON_BLACK;
	}

	// reset cursor to upper left corner of screen
	set_cursor(get_screen_offset(0, 0));
}
