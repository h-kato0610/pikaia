import token
from strformat import fmt

const
    BYTE_ASSIGN = '='.byte
    BYTE_SEMICOLON = ';'.byte
    BYTE_LPAREN = '('.byte
    BYTE_RPAREN = ')'.byte
    BYTE_COMMA = ','.byte
    BYTE_PLUS = '+'.byte
    BYTE_MINUS = '-'.byte
    BYTE_LBRACE = '{'.byte
    BYTE_RBRACE = '}'.byte

type Lexer* = ref object
    input*: string
    position*: int # 入力における現在の位置（現在の文字の位置を示す）
    readPosition*: int # これから読み込む位置（現在の文字の次）
    ch*: byte # 現在検査中の文字

# Define
proc newLexer*(input: string): Lexer
proc newToken(tokenType: TokenType, ch: byte): Token
proc nextToken(lex: Lexer): Token
proc readChar(lex: Lexer)

# Implement
proc newLexer*(input: string): Lexer =
    new result

    result.input = input
    result.readChar()

proc newToken(tokenType: TokenType, ch: byte): Token =
    let str = fmt"{$ch.byte.char}"
    return Token(Type: tokenType, Literal: str)

proc nextToken(lex: Lexer): Token =
    var getReadToken: Token

    case lex.ch
        of BYTE_ASSIGN:
            getReadToken = newToken(token.ASSIGN, lex.ch)
        of BYTE_SEMICOLON:
            getReadToken = newToken(token.SEMICOLON, lex.ch)
        of BYTE_LPAREN:
            getReadToken = newToken(token.LPAREN, lex.ch)
        of BYTE_RPAREN:
            getReadToken = newToken(token.RPAREN, lex.ch)
        of BYTE_COMMA:
            getReadToken = newToken(token.COMMA, lex.ch)
        of BYTE_PLUS:
            getReadToken = newToken(token.PLUS, lex.ch)
        of BYTE_LBRACE:
            getReadToken = newToken(token.LBRACE, lex.ch)
        of BYTE_RBRACE:
            getReadToken = newToken(token.RBRACE, lex.ch)
        of 0:
            getReadToken.Literal = ""
            getReadToken.Type = token.EOF
        else:
            # implemented yet
            discard

    lex.readChar()
    return getReadToken

proc readChar(lex: Lexer) =
    lex.ch = if lex.readPosition >= lex.input.len(): 0.byte
             else: lex.input[lex.readPosition].byte
    
    lex.position = lex.readPosition
