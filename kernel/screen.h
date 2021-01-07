#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f

// screen device io constants
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

int get_screen_offset(int, int);
int get_cursor();
void set_cursor(int);
void print_char(char, int, int, char);
void print_at(char*, int, int);
void print(char*);
void cls();
