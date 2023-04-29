import tables

type TokenType* = string

type Token* = ref object
    Type*: TokenType
    Literal*: string

const
    ILLEGAL* = "ILLEGAL"
    EOF* = "EOF"

    # 識別子 + リテラル
    IDENT* = "IDENT" # add, foobar, x, y, ...
    INT* = "INT" # 123456

    # 演算子
    ASSIGN* = "="
    PLUS* = "+"
    MINUS* = "-"
    ASTERISK* = "*"
    SLASH* = "/"

    BANG* = "!"

    LT* = "<"
    GT* = ">"

    # デリミタ
    COMMA* = ","
    SEMICOLON* = ";"

    LPAREN* = "("
    RPAREN* = ")"
    LBRACE* = "{"
    RBRACE* = "}"

    # キーワード
    FUNCTION* = "FUNCTION"
    LET* = "LET"
    TRUE* = "TRUE"
    FALSE* = "FALSE"
    IF* = "IF"
    ELSE* = "ELSE"
    RETURN* = "RETURN"

var keywords = {
    "fn": FUNCTION,
    "let": LET,
    "true": TRUE,
    "false": FALSE,
    "if": IF,
    "else": ELSE,
    "return": RETURN,
}.newTable

# define
proc lookUpIdent*(ident: string): TokenType
proc newMultiLiteralToken*(tokenType: TokenType, tokenLiteral: string): Token

# implement
proc lookUpIdent*(ident: string): TokenType = 
    return if keywords.hasKey(ident): keywords[ident] else: IDENT

proc newMultiliteralToken*(tokenType: TokenType, tokenLiteral: string): Token =
    return Token(Type: tokenType, Literal: tokenLiteral)