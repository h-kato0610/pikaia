proc isLetter*(ch: byte): bool =
    return('a'.byte <= ch and ch <= 'z'.byte) or
          ('A'.byte <= ch and ch <= 'Z'.byte) or
          ('_'.byte == ch)