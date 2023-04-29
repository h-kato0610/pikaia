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
    BYTE_ASTERISK = '*'.byte
    BYTE_SLASH = '/'.byte
    BYTE_BANG = '!'.byte
    BYTE_LT = '<'.byte
    BYTE_GT = '>'.byte
    BYTE_LBRACE = '{'.byte
    BYTE_RBRACE = '}'.byte

type Lexer* = ref object
    input*: string
    position*: int # 入力における現在の位置（現在の文字の位置を示す）
    readPosition*: int # これから読み込む位置（現在の文字の次）
    ch*: byte # 現在検査中の文字

# Define
proc isDigit(ch: byte): bool
proc isLetter(ch: byte): bool
proc isSpace(ch: char): bool
proc newLexer*(input: string): Lexer
proc newToken(tokenType: TokenType, ch: byte): Token
proc nextToken*(lex: Lexer): Token
proc readChar(lex: Lexer)
proc readIdentifier(lex: Lexer): string
proc readNumber(lex: Lexer): string
proc skipWhiteSpace(lex: Lexer): void {.inline.}

# Implement
proc isSpace(ch: char): bool =
    return ch == ' ' or ch == '\t' or
           ch == '\n' or ch == '\r'

proc isLetter(ch: byte): bool =
    return ('a'.byte <= ch and ch <= 'z'.byte) or
           ('A'.byte <= ch and ch <= 'Z'.byte) or
           ('_'.byte == ch)

proc isDigit(ch: byte): bool =
    return if '0'.byte <= ch and ch <= '9'.byte: true else: false

proc newLexer*(input: string): Lexer =
    new result

    result.input = input
    result.readChar()

proc newToken(tokenType: TokenType, ch: byte): Token =
    let str = fmt"{$ch.byte.char}"
    return Token(Type: tokenType, Literal: str)

proc nextToken*(lex: Lexer): Token =
    var getReadToken: Token

    lex.skipWhiteSpace()

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
        of BYTE_MINUS:
            getReadToken = newToken(token.MINUS, lex.ch)
        of BYTE_ASTERISK:
            getReadToken = newToken(token.ASTERISK, lex.ch)
        of BYTE_SLASH:
            getReadToken = newToken(token.SLASH, lex.ch)
        of BYTE_BANG:
            getReadToken = newToken(token.BANG, lex.ch)
        of BYTE_LT:
            getReadToken = newToken(token.LT, lex.ch)
        of BYTE_GT:
            getReadToken = newToken(token.GT, lex.ch)
        of BYTE_LBRACE:
            getReadToken = newToken(token.LBRACE, lex.ch)
        of BYTE_RBRACE:
            getReadToken = newToken(token.RBRACE, lex.ch)
        else:
            if lex.ch.isLetter():
                let identIdentifier = lex.readIdentifier()
                return newMultiLiteralToken(token.lookUpIdent(identIdentifier),
                                                                      identIdentifier)
            elif lex.ch.isDigit():
                return newMultiLiteralToken(token.INT, lex.readNumber)
            else:
                getReadToken = newToken(token.ILLEGAL, lex.ch)

    lex.readChar()

    return getReadToken

proc readChar(lex: Lexer) =
    lex.ch = if lex.readPosition >= lex.input.len(): 0.byte
             else: lex.input[lex.readPosition].byte
    
    lex.position = lex.readPosition
    lex.readPosition += 1

proc readIdentifier(lex: Lexer): string =
    let position = lex.position
    while isLetter(lex.ch):
        lex.readChar()

    return lex.input[position..(lex.position - 1)]

proc readNumber(lex: Lexer): string =
    var resultString: string
    while lex.ch.isDigit(): 
        resultString = resultString & lex.ch.char
        lex.readChar()

    return resultString

proc skipWhiteSpace(lex: Lexer): void {.inline.} =
    while lex.ch.char.isSpace():
        lex.readChar()