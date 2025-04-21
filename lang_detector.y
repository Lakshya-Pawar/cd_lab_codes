%{
#include <stdio.h>
#include <string.h>

int c_keywords = 0, cpp_keywords = 0, java_keywords = 0, python_keywords = 0;

void yyerror(const char *s) {}
int yylex(void);
%}

%token C_KEYWORD CPP_KEYWORD JAVA_KEYWORD PYTHON_KEYWORD

%%

input:
    /* empty */
    | input language_element
    ;

language_element:
      C_KEYWORD        { c_keywords++; }
    | CPP_KEYWORD      { cpp_keywords++; }
    | JAVA_KEYWORD     { java_keywords++; }
    | PYTHON_KEYWORD   { python_keywords++; }
    ;

%%

int main() {
    yyparse();

    if (python_keywords > java_keywords && python_keywords > cpp_keywords && python_keywords > c_keywords)
        printf("Detected Language: Python\n");
    else if (java_keywords > cpp_keywords && java_keywords > c_keywords)
        printf("Detected Language: Java\n");
    else if (cpp_keywords > c_keywords)
        printf("Detected Language: C++\n");
    else if (c_keywords > 0)
        printf("Detected Language: C\n");
    else
        printf("Language could not be determined.\n");

    return 0;
}
