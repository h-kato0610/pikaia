import unittest

import ../src/lexer/lexer
import ../src/lexer/token

suite "TokenTest":
    test "testNextToken":
        let input = """
            let five = 5;
            let ten = 10;

            let add = fn(x, y) {
                x + y;     
            };

            let result = add(five, ten);
        """

        let tests = @[
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
            (LET, "let"),
            (IDENT, "add"),
            (ASSIGN, "="),
            (FUNCTION, "fn"),
            (LPAREN, "("),
            (IDENT, "x"),
            (COMMA, ","),
            (IDENT, "y"),
            (RPAREN, ")"),
            (LBRACE, "{"),
            (IDENT, "x"),
            (PLUS, "+"),
            (IDENT, "y"),
            (SEMICOLON, ";"),
            (RBRACE, "}"),
            (SEMICOLON, ";"),
            (LET, "let"),
            (IDENT, "result"),
            (ASSIGN, "="),
            (IDENT, "add"),
            (LPAREN, "("),
            (IDENT, "five"),
            (COMMA, ","),
            (IDENT, "ten"),
            (RPAREN, ")"),
            (SEMICOLON, ";"),
            (EOF, ""),
        ]

        let lexer = newLexer(input)

        for test in tests:
            var currentToken = lexer.nextToken()

            check(test[0] == currentToken.Type) 
            check(test[1] == currentToken.Literal) 