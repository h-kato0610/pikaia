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

            if (5 < 10) {
                return true;
            } else {
                return false;
            }
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
            (SLASH, "/"),
            (ASTERISK, "*"),
            (INT, "5"),
            (SEMICOLON, ";"),

            (INT, "5"),
            (LT, "<"),
            (INT, "10"),
            (GT, ">"),
            (INT, "5"),
            (SEMICOLON, ";"),

            (IF, "if" ),
            (LPAREN, "("),
            (INT, "5" ),
            (LT, "<" ),
            (INT, "10" ),
            (RPAREN, ")"),
            (LBRACE, "{"),
            (RETURN, "return"),
            (TRUE, "true"),
            (SEMICOLON, ";"),
            (RBRACE, "}"),
            (ELSE, "else"),
            (LBRACE, "{"),
            (RETURN, "return"),
            (FALSE, "false"),
            (SEMICOLON, ";"),
            (RBRACE, "}"),
        ]
        let lexer = newLexer(input)

        for i, test in tests:
            var currentToken = lexer.nextToken()

            check(test[0] == currentToken.Type) 
            check(test[1] == currentToken.Literal) 