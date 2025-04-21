%{
#include "y.tab.h"
%}

%%
"#include"                { return C_KEYWORD; }
"printf"                 { return C_KEYWORD; }
"scanf"                  { return C_KEYWORD; }

"iostream"               { return CPP_KEYWORD; }
"std::"                  { return CPP_KEYWORD; }
"cin"|"cout"             { return CPP_KEYWORD; }

"public"|"class"|"static"|"void"|"main" { return JAVA_KEYWORD; }
"System.out.println"     { return JAVA_KEYWORD; }

"def"|"import"|"print"|"self"|"elif" { return PYTHON_KEYWORD; }

[a-zA-Z_][a-zA-Z0-9_]*    ;
[ \t\n\r]+                ;
.                         ;
%%

int yywrap() {
    return 1;
}
