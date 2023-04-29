import
    ../lexer/token,
    ../lexer/lexer,

    strformat


const PROMPT = ">> "

proc start*() =
    while true:
        stdout.write PROMPT

        let 
            line = stdin.readLine()
            lex = newLexer(line)
        
        var token = lex.nextToken()
        while token.Type != EOF:
            # echo(fmt"{$lex.ch.byte.char}")
            # echo(fmt"${token.Literal.ch.byte.char}")
            echo(fmt"{$token.Literal}")
            token = lex.nextToken()