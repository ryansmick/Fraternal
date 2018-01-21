// Author: Ryan Smick (rsmick)
// Main function for the fraternal compiler

#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
extern char* yytext;
extern int yylex();
extern int yyparse();

void usage();

int main(int argc, char* argv[]) {

	// Print usage if command line arguments are incorrect
	if(argc != 3) {
		usage();
	}
	
	if (strcmp(argv[1], "-scan") && strcmp(argv[1], "-print")) {
		usage();
	}

	yyin = fopen(argv[2], "r");

	// Handle opening errors
	if(yyin == 0) {
		printf("Error: File %s could not be opened. Exiting...\n", argv[2]);
		return 1;
	}

	// Read through file and scan
	if(!strcmp(argv[1], "-scan")) {
		while(1) {
			int t = yylex();
			switch(t) {
				printf("%d\n", t);
				case TOKEN_ERROR:
					fprintf(stderr, "Scan error: \"%s\" is not a valid token\n", yytext);
					exit(1);
					break;
				case TOKEN_EOF:
					printf("TOKEN_EOF\n");
					exit(0);
					break;
				case TOKEN_BOOLEAN:
					printf("TOKEN_BOOLEAN\n");
					break;
				case TOKEN_CHAR:
					printf("TOKEN_CHAR\n");
					break;
				case TOKEN_ELIF:
					printf("TOKEN_ELIF\n");
					break;
				case TOKEN_ELSE:
					printf("TOKEN_ELSE\n");
					break;
				case TOKEN_FALSE:
					printf("TOKEN_FALSE\n");
					break;
				case TOKEN_FOR:
					printf("TOKEN_FOR\n");
					break;
				case TOKEN_FUNCTION:
					printf("TOKEN_FUNCTION\n");
					break;
				case TOKEN_IF:
					printf("TOKEN_IF\n");
					break;
				case TOKEN_INTEGER:
					printf("TOKEN_INTEGER\n");
					break;
				case TOKEN_PRINT:
					printf("TOKEN_PRINT\n");
					break;
				case TOKEN_RETURN:
					printf("TOKEN_RETURN\n");
					break;
				case TOKEN_STRING:
					printf("TOKEN_STRING\n");
					break;
				case TOKEN_NULLABLE_STRING:
					printf("TOKEN_NULLABLE_STRING\n");
					break;
				case TOKEN_TRUE:
					printf("TOKEN_TRUE\n");
					break;
				case TOKEN_VOID:
					printf("TOKEN_VOID\n");
					break;
				case TOKEN_WHILE:
					printf("TOKEN_WHILE\n");
					break;
				case TOKEN_NEWLINE:
					printf("TOKEN_NEWLINE\n");
					break;
				case TOKEN_NULL:
					printf("TOKEN_NULL\n");
					break;
				case TOKEN_LEFT_BRACKET:
					printf("TOKEN_LEFT_BRACKET\n");
					break;
				case TOKEN_RIGHT_BRACKET:
					printf("TOKEN_RIGHT_BRACKET\n");
					break;
				case TOKEN_LEFT_PAREN:
					printf("TOKEN_LEFT_PAREN\n");
					break;
				case TOKEN_RIGHT_PAREN:
					printf("TOKEN_RIGHT_PAREN\n");
					break;
				case TOKEN_LEFT_CURLY:
					printf("TOKEN_LEFT_CURLY\n");
					break;
				case TOKEN_RIGHT_CURLY:
					printf("TOKEN_RIGHT_CURLY\n");
					break;
				case TOKEN_ARROW:
					printf("TOKEN_ARROW\n");
					break;
				case TOKEN_PLUS:
					printf("TOKEN_PLUS\n");
					break;
				case TOKEN_MINUS:
					printf("TOKEN_MINUS\n");
					break;
				case TOKEN_NOT:
					printf("TOKEN_NOT\n");
					break;
				case TOKEN_BITWISE_NOT:
					printf("TOKEN_BITWISE_NOT\n");
					break;
				case TOKEN_XOR:
					printf("TOKEN_XOR\n");
					break;
				case TOKEN_MULT:
					printf("TOKEN_MULT\n");
					break;
				case TOKEN_DIVIDE:
					printf("TOKEN_DIVIDE\n");
					break;
				case TOKEN_MODULUS:
					printf("TOKEN_MODULUS\n");
					break;
				case TOKEN_SHIFT_LEFT:
					printf("TOKEN_SHIFT_LEFT\n");
					break;
				case TOKEN_SHIFT_RIGHT:
					printf("TOKEN_SHIFT_RIGHT\n");
					break;
				case TOKEN_LT:
					printf("TOKEN_LT\n");
					break;
				case TOKEN_GT:
					printf("TOKEN_GT\n");
					break;
				case TOKEN_ASSIGN:
					printf("TOKEN_ASSIGN\n");
					break;
				case TOKEN_AND:
					printf("TOKEN_AND\n");
					break;
				case TOKEN_OR:
					printf("TOKEN_OR\n");
					break;
				case TOKEN_BITWISE_AND:
					printf("TOKEN_BITWISE_AND\n");
					break;
				case TOKEN_BITWISE_OR:
					printf("TOKEN_BITWISE_OR\n");
					break;
				case TOKEN_COLON:
					printf("TOKEN_COLON\n");
					break;
				case TOKEN_SEMICOLON:
					printf("TOKEN_SEMICOLON\n");
					break;
				case TOKEN_COMMA:
					printf("TOKEN_COMMA\n");
					break;
				case TOKEN_EQUAL:
					printf("TOKEN_EQUAL\n");
					break;
				case TOKEN_PLUS_EQUAL:
					printf("TOKEN_PLUS_EQUAL\n");
					break;
				case TOKEN_MINUS_EQUAL:
					printf("TOKEN_MINUS_EQUAL\n");
					break;
				case TOKEN_GE:
					printf("TOKEN_GE\n");
					break;
				case TOKEN_LE:
					printf("TOKEN_LE\n");
					break;
				case TOKEN_NE:
					printf("TOKEN_NE\n");
					break;
				case TOKEN_ID:
					printf("TOKEN_ID %s\n", yytext);
					break;
				case TOKEN_INTEGER_LITERAL:
					printf("TOKEN_INTEGER_LITERAL %s\n", yytext);
					break;
				case TOKEN_STRING_LITERAL:
					printf("TOKEN_STRING_LITERAL %s\n", yytext);
					break;
				case TOKEN_CHAR_LITERAL:
					printf("TOKEN_CHAR_LITERAL %s\n", yytext);
					break;
			}	
		}

	}

	return 0;

}

void usage() {
	printf("Usage: cminor <options> <filename>\n");
	exit(1);
}
