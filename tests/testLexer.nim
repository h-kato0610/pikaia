import unittest

import ../src/lexer/lexer
import ../src/lexer/token

suite "TokenTest":
    test "testNextToken":
        const input = """
            let five = 5;
            let ten = 10;
        """
        const tests = @[
            (LET, "let"),
            (IDENT, "five"),
            (ASSIGN, "="),
            (INT, "5"),
            (SEMICOLON, ";"),
            (LET, "let"),
            (IDENT, "ten"),
            (ASSIGN, "="),
            (INT, "10"),
            (SEMICOLON, ";"),
        ]
        let lexer = newLexer(input)

        for i, test in tests:
            var currentToken = lexer.nextToken()

            echo("+++++++++")
            echo(test[0])
            echo(currentToken.Type)
            echo("-----------")
            echo(test[1])
            echo(currentToken.Literal)
            echo("+++++++++")
            echo("test end")

            check(test[0] == currentToken.Type) 
            check(test[1] == currentToken.Literal) 