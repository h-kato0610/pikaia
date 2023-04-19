type TokenType = string

type Tokens = object
    Type: TokenType
    Literal: string

const
    ILLEGA = "ILLEGAL"
    EOF = "EOF"

    # 識別子 + リテラル
    IDENT = "IDENT" # add, foobar, x, y, ...
    INT = "INT" # 123456

    # 演算子
    ASSIGNN = "="
    PLUS = "+"

    # デリミタ
    COMMA = ","
    SEMICOLON = ";"

    LPAREN = "("
    RPAREN = ")"
    LBRACE = "{"
    RBRACE = "}"

    # キーワード
    FUNCTION = "FUNCTION"
    LET = "LET"