import
    ../lexer/token,
    ../lexer/lexer,

    strformat

const PROMPT = ">> "

proc start*(): void

proc start*(): void =
    while true:
        stdout.write PROMPT

        let 
            line = stdin.readLine()
            lex = newLexer(line)
        
        var token = lex.nextToken()
        while token.Type != EOF:
            echo(fmt"Type: [{$token.Type}] Literal: [{$token.Literal}]")
            token = lex.nextToken()