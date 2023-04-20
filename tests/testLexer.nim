import unittest

import ../src/lexer/lexer
import ../src/lexer/token

suite "TokenTest":
    test "testNextToken":
        let input = "=+(){},;"

        const tests = @[
            (token.ASSIGN, "="),
            (token.PLUS, "+"),
            (token.LPAREN, "("),
            (token.RPAREN, ")"),
            (token.LBRACE, "{"),
            (token.RBRACE, "}"),
            (token.COMMA, ","),
            (token.SEMICOLON, ";"),
            (token.EOF, ""),
        ]

        var tokenizer = lexer.newLexer(input)

        for test in tests:
            let currentToken = tokenizer.getNextToken()

            check(test[0] == currentToken.Type)
            check(test[1] == currentToken.Litera)
