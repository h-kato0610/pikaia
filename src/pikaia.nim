import repl/repl

const greeting = "Hello, This is the pikaia programming language!"
const inTypeCommand = "Feel free to type Commands\n"

when isMainModule:
  echo(greeting)
  echo(inTypeCommand)
  repl.start()
