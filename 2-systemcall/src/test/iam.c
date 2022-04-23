#define __LIBRARY__
#include <unistd.h>
#include <stdio.h>

_syscall1(int, iam, const char*, name)

#define NAMELEN 100
char name[NAMELEN];

int main(int argc, char *argv[]) {
	int nameLen = 0;
	int result;

	printf("hello test iam");
	if (argc >= 2) {
		while ((name[nameLen] = argv[1][nameLen]) != '\0') {
			nameLen++;
		}
		printf("str: %s, len: %d\n", name, nameLen);
		result = iam(name);
		printf("res = %d\n", result);
	} else {
		printf("number of parameter less than 1\n");
	}
	return 0;
}
