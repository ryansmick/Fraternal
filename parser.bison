/*
declare token types at the top of the bison file,
causing them to be automatically generated in parser.tab.h
for use by scanner.c.
*/

%token TOKEN_ERROR
%token TOKEN_ID
%token TOKEN_BOOLEAN
%token TOKEN_CHAR
%token TOKEN_ELSE
%token TOKEN_FALSE
%token TOKEN_FOR
%token TOKEN_FUNCTION
%token TOKEN_IF
%token TOKEN_INTEGER
%token TOKEN_PRINT
%token TOKEN_RETURN
%token TOKEN_STRING
%token TOKEN_NULLABLE_STRING
%token TOKEN_TRUE
%token TOKEN_VOID
%token TOKEN_WHILE
%token TOKEN_BREAK
%token TOKEN_CONTINUE
%token TOKEN_NEWLINE
%token TOKEN_NULL
%token TOKEN_LEFT_BRACKET
%token TOKEN_RIGHT_BRACKET
%token TOKEN_LEFT_PAREN
%token TOKEN_RIGHT_PAREN
%token TOKEN_LEFT_CURLY
%token TOKEN_RIGHT_CURLY
%token TOKEN_PLUS
%token TOKEN_MINUS
%token TOKEN_NOT
%token TOKEN_BITWISE_NOT
%token TOKEN_XOR
%token TOKEN_MULT
%token TOKEN_DIVIDE
%token TOKEN_MODULUS
%token TOKEN_SHIFT_LEFT
%token TOKEN_SHIFT_RIGHT
%token TOKEN_LT
%token TOKEN_GT
%token TOKEN_ASSIGN
%token TOKEN_AND
%token TOKEN_OR
%token TOKEN_BITWISE_AND
%token TOKEN_BITWISE_OR
%token TOKEN_COLON
%token TOKEN_SEMICOLON
%token TOKEN_COMMA
%token TOKEN_PLUS_EQUAL
%token TOKEN_MINUS_EQUAL
%token TOKEN_EQUAL
%token TOKEN_GE
%token TOKEN_LE
%token TOKEN_NE
%token TOKEN_INTEGER_LITERAL
%token TOKEN_STRING_LITERAL
%token TOKEN_CHAR_LITERAL
%token TOKEN_EOF

%{

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
Clunky: Manually declare the interface to the scanner generated by flex. 
*/

extern char *yytext;
extern int yylex();
extern int yyerror( char *str );
extern char* original_literal;

/*
Clunky: Keep the final result of the parse in a global variable,
so that it can be retrieved by main().
*/

struct decl* parser_result;

%}

%%

/* Here is the grammar: program is the start symbol. */

program : decl_list TOKEN_EOF
	;

decl_list	: decl decl_list
		|
		;

decl	: decl2 TOKEN_SEMICOLON
	| decl2 TOKEN_ASSIGN expr TOKEN_SEMICOLON
	| ident TOKEN_COLON function_type TOKEN_ASSIGN TOKEN_LEFT_CURLY stmt_list TOKEN_RIGHT_CURLY
	| ident TOKEN_COLON function_type TOKEN_SEMICOLON
	| decl2 TOKEN_ASSIGN TOKEN_LEFT_CURLY expr_list TOKEN_RIGHT_CURLY TOKEN_SEMICOLON
	;

decl2	: ident TOKEN_COLON type
	;

stmt_list	: stmt stmt_list
		|
		;

stmt	: TOKEN_IF TOKEN_LEFT_PAREN expr TOKEN_RIGHT_PAREN stmt
	| TOKEN_IF TOKEN_LEFT_PAREN expr TOKEN_RIGHT_PAREN stmt2 TOKEN_ELSE stmt
	| TOKEN_FOR TOKEN_LEFT_PAREN opt_expr TOKEN_SEMICOLON opt_expr TOKEN_SEMICOLON opt_expr TOKEN_RIGHT_PAREN stmt
	| stmt3
	;

stmt2	: TOKEN_IF TOKEN_LEFT_PAREN expr TOKEN_RIGHT_PAREN stmt2 TOKEN_ELSE stmt2
	| TOKEN_FOR TOKEN_LEFT_PAREN opt_expr TOKEN_SEMICOLON opt_expr TOKEN_SEMICOLON opt_expr TOKEN_RIGHT_PAREN stmt2
	| stmt3
	;

stmt3	: decl
	| TOKEN_LEFT_CURLY stmt_list TOKEN_RIGHT_CURLY
	| expr TOKEN_SEMICOLON
	| TOKEN_PRINT expr_list TOKEN_SEMICOLON
	| TOKEN_RETURN expr TOKEN_SEMICOLON
	| TOKEN_RETURN TOKEN_SEMICOLON
	;

assignee	: assignee TOKEN_LEFT_BRACKET expr TOKEN_RIGHT_BRACKET
		| ident
		;

expr	: assignee TOKEN_ASSIGN expr
	| assignee TOKEN_PLUS_EQUAL expr
	| assignee TOKEN_MINUS_EQUAL expr
	| expr2
	;

expr2	: expr2 TOKEN_OR expr3
	| expr3
	;

expr3	: expr3 TOKEN_AND expr4
	| expr4
	;

expr4	: expr4 TOKEN_LT expr5
	| expr4 TOKEN_LE expr5
	| expr4 TOKEN_GT expr5
	| expr4 TOKEN_GE expr5
	| expr4 TOKEN_EQUAL expr5
	| expr4 TOKEN_NE expr5
	| expr5
	;

expr5	: expr5 TOKEN_PLUS expr6
	| expr5 TOKEN_MINUS expr6
	| expr6
	;

expr6	: expr6 TOKEN_MULT expr7
	| expr6 TOKEN_DIVIDE expr7
	| expr6 TOKEN_MODULUS expr7
	| expr7
	;

expr7	: expr7 TOKEN_XOR expr8
	| expr8
	;

expr8	: TOKEN_MINUS expr9
	| TOKEN_NOT expr9
	| expr9
	;

expr9	: expr10
	;

expr10	: literal
	| TOKEN_LEFT_PAREN expr TOKEN_RIGHT_PAREN
	| assignee TOKEN_LEFT_PAREN expr_list TOKEN_RIGHT_PAREN
	| assignee
	;

literal	: TOKEN_TRUE
	| TOKEN_FALSE
	| TOKEN_INTEGER_LITERAL
	| TOKEN_STRING_LITERAL
	| TOKEN_CHAR_LITERAL
	;

expr_list	: expr expr_list2
		|
		;

expr_list2	: TOKEN_COMMA expr expr_list2
		|
		;

type	: TOKEN_INTEGER
	| TOKEN_BOOLEAN
	| TOKEN_STRING
	| TOKEN_CHAR
	| TOKEN_VOID
	;

function_type	: TOKEN_FUNCTION type TOKEN_LEFT_PAREN param_list TOKEN_RIGHT_PAREN
		;

param_list	: decl2 param_list2
		|
		;

param_list2	: TOKEN_COMMA decl2 param_list2
		|
		;

ident	: TOKEN_ID
	;

opt_expr	: expr
		|
		;

%%

/*
This function will be called by bison if the parse should
encounter an error.  In principle, "str" will contain something
useful.  In practice, it often does not.
*/

int yyerror( char *str )
{
	printf("parse error: %s\n",str);
	exit(1);
}
