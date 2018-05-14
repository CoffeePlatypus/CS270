#include <stdio.h>

#include <stdlib.h>

void swap(int *i, int*j) {
	int temp = *i;
	*i = *j;
	*j = temp;
}

void sort(int n[], int size) {
	int *i;
	int *s;
	int *p;

	for (p = n; p < n+size -1; p++) {
		s = p;
		for (i = p+1; i < n + size; i++) {

			if (*i < *s) {
				s = i;;
			}
		}
		swap(p, s);
	}
}

int main(int argc, char * argv[]) {
	int numbers[30];
	int count;
	int i;
	printf("How many numbers will you enter: ");
	scanf("%d", &count);
	if (count > 30) {
		printf("You must enter a number between 1 and 30\n");
		exit(1);
	}
	printf("Enter %d number separated by white space: ", count);
	i = 0;
	while (i < count) {
		scanf("%d", &numbers[i]);
		i++;
	}
	sort(numbers, count);
	printf("The numbers in ascending order are\n");
	for (i = 0; i < count; i++) {
		printf("%d ", numbers[i]);
	}
	printf("\n");
}
