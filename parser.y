%{
int yylex(void);
void yyerror (char const *s);
%}

%token TK_PR_INT
%token TK_PR_FLOAT
%token TK_PR_BOOL
%token TK_PR_CHAR
%token TK_PR_STRING

%token TK_PR_IF
%token TK_PR_THEN
%token TK_PR_ELSE
%token TK_PR_WHILE
%token TK_PR_DO
%token TK_PR_INPUT
%token TK_PR_OUTPUT
%token TK_PR_RETURN
%token TK_PR_CONST
%token TK_PR_STATIC
%token TK_PR_FOREACH
%token TK_PR_FOR
%token TK_PR_SWITCH
%token TK_PR_CASE
%token TK_PR_BREAK
%token TK_PR_CONTINUE
%token TK_PR_CLASS
%token TK_PR_PRIVATE
%token TK_PR_PUBLIC
%token TK_PR_PROTECTED
%token TK_PR_END
%token TK_PR_DEFAULT

%token TK_OC_LE
%token TK_OC_GE
%token TK_OC_EQ
%token TK_OC_NE
%token TK_OC_AND
%token TK_OC_OR
%token TK_OC_SL
%token TK_OC_SR

%token TK_LIT_INT
%token TK_LIT_FLOAT
%token TK_LIT_FALSE
%token TK_LIT_TRUE
%token TK_LIT_CHAR
%token TK_LIT_STRING
%token TK_IDENTIFICADOR
%token TOKEN_ERRO

%right '&' '*' '#'

%start programa

%%

programa:
    conjunto_programa conjunto_programa
    ;
conjunto_programa:
    variaveis_globais           
    | funcoes
    |
    ;

variaveis_globais:
    static tipo nome_var tam_vetor ';'
    ;
nome_var:
    identificador
    | nome_var
    | ',' nome_var
    ;
tam_vetor:
    '[' inteiro ']'
    |
    ;
inicia_var:
    menor_igual identificador
    | menor_igual literal
    |
    ;

funcoes:
    cabecalho corpo_bloco 
    ;

cabecalho:
    static tipo nome_func '(' lista_param ')'
    ;
corpo_bloco:
    '{' comando_simples ';' '}'
    | '{' '}'
    ;

comando_simples:
    corpo_bloco
    | var_local
    | atribuicao
    | entrada
    | saida
    | retorno
    | break 
    | continue
    | shift
    | controle_fluxo
    | cham_funcao
    ;

var_local:
    tipo static const nome_var inicia_var
    ;
atribuicao:
    identificador '=' expressao
    | identificador '=' expressao
    ;
entrada:
    input identificador
    ;
saida:
    output identificador
    | output literal
    ;
retorno:
    return expressao
    ;
shift:
    identificador lit_shift inteiro
    | identificador '[' expressao ']' lit_shift inteiro
    ;
controle_fluxo:
    if '(' expressao ')' corpo_bloco else_opc
    | for '(' atribuicao ':' expressao ':' atribuicao ')' corpo_bloco
    | while '(' expressao ')' do corpo_bloco
    ;
else_opc:
    else corpo_bloco
    |
    ;
cham_funcao:
    nome_func '(' lista_arg ')'
    ;

expressao:
    '(' expressao ')'
    | '+' expressao
    | '-' expressao
    | '!' expressao
    | '&' expressao
    | '*' expressao
    | '?' expressao
    | '#' expressao
    | expressao '+'          expressao
    | expressao '-'          expressao
    | expressao '/'          expressao
    | expressao '%'          expressao
    | expressao '|'          expressao
    | expressao '&'          expressao
    | expressao '^'          expressao
    | expressao menor_igual  expressao
    | expressao maior_igual  expressao
    | expressao diferente    expressao
    | expressao igual        expressao
    | expressao e_logico     expressao
    | expressao ou_logico    expressao
    | expressao shf_r        expressao
    | expressao shf_l        expressao
    | expressao '?' expressao ':' expressao
    | operando
    ;
operando:
    identificador tam_vetor
    | inteiro
    | pt_flut
    | cham_funcao
    | booleano
    ;

\* LISTAS *\

lista_arg:
    expressao
    | lista_arg
    | ',' lista_arg
    ;
lista_param:
    const tipo identificador
    | ',' lista_param
    ;

\* FOLHAS *\
for:
    TK_PR_FOR
    ;
while:
    TK_PR_WHILE
    ;
do:
    TK_PR_DO
    ;
if:
    TK_PR_IF
    ;
else:
    TK_PR_ELSE
    ;
output:
    TK_PR_OUTPUT
    ;
input:
    TK_PR_INPUT
    ;
return:
    TK_PR_RETURN
    ;
continue:
    TK_PR_CONTINUE
    ;
break:
    TK_PR_BREAK
    ;
menor_igual:
    TK_OC_LE
    ;
lit_shift:
    TK_OC_SR
    | TK_OC_SL
    ;
literal:
    TK_LIT_INT
    | TK_LIT_FLOAT
    | TK_LIT_CHAR
    | TK_LIT_STRING
    ;
inteiro:
    TK_LIT_INT
    ;
pt_flut:
    TK_LIT_FLOAT
    ;
booleano:
    TK_LIT_TRUE
    | TK_LIT_FALSE
    ;
identificador:
    TK_IDENTIFICADOR
    ;
const:
    TK_PR_CONST
    |
    ;
static:
    TK_PR_STATIC
    |
    ;
tipo:
    TK_PR_INT
    | TK_PR_FLOAT
    | TK_PR_BOOL
    | TK_PR_CHAR
    | TK_PR_STRING
    ;
%%