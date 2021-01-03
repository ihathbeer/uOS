inline void iamthewalrus(){}


void main(){
    // pt to video mem
    char* video_memory = (char*) 0xb8000;
	// greeting to print
	const char* greeting = "#iamthewalrus";

	// initialize iterator 
	char* it = greeting;
	// initialize offset
	int k = 0;
	
	while(*it != '\0') {
		*(video_memory+2*(k++)) = *it++;
	}
}
