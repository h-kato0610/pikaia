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

var keywords = {
    "fn": FUNCTION,
    "let": LET,
}.newTable

# define
proc lookUpIdent*(ident: string): TokenType
proc newMultiLiteralToken*(tokenType: TokenType, tokenLiteral: string): Token

# implement
proc lookUpIdent*(ident: string): TokenType = 
    return if keywords.hasKey(ident): keywords[ident] else: IDENT

proc newMultiliteralToken*(tokenType: TokenType, tokenLiteral: string): Token =
    return Token(Type: tokenType, Literal: tokenLiteral)