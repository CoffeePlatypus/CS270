#include <stdio.h>

int main(int argc, char * argv[]) {
	char name[50];
	int count;
	int i;
	printf("How many are watching: ");
	scanf("%d", &count);
	i = 0;
	while (i < count) {
		printf("Enter one name: ");
        scanf("%s", name);
		printf("Hello %s\n", name);
		i++;
	}
}
