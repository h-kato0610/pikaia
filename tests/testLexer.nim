import unittest

import ../src/lexer/lexer
import ../src/lexer/token

suite "TokenTest":
    test "testNextToken":
        const input = """
            let five = 5;
            let ten = 10;

            let add = fn(x, y) = {
                x + y;
            };

            let result = add(five, ten);
            !-/*5;
            5 < 10 > 5;
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

            (LET, "let"),
            (IDENT, "add"),
            (ASSIGN, "="),
            (FUNCTION, "fn"),
            (LPAREN, "("),
            (IDENT, "x"),
            (COMMA, ","),
            (IDENT, "y"),
            (RPAREN, ")"),
            (ASSIGN, "="),
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

            (BANG, "!"),
            (MINUS, "-"),
            (ASTERISK, "*"),
            (SLASH, "/"),
            (IDENT, "five"),
            (SEMICOLON, ";"),

            (IDENT, "five"),
            (LT, "<"),
            (IDENT, "ten"),
            (GT, ">"),
            (IDENT, "five"),
            (SEMICOLON, ";"),
        ]
        let lexer = newLexer(input)

        for i, test in tests:
            var currentToken = lexer.nextToken()

            check(test[0] == currentToken.Type) 
            check(test[1] == currentToken.Literal) 