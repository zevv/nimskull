discard """
  output: '''("string here", 80)'''
  cmd: '''nim c --gc:arc --expandArc:main --expandArc:sio --hint:Performance:off $file'''
  nimout: '''--expandArc: main

scope:
  try:
    def_cursor x: (string, int) = <D0>
    block L0:
      if cond:
        scope:
          x = <D1>
          break L0
      scope:
        x = <D2>
    def_cursor _0: (string, int) = x
    def _1: string = $(arg _0) (raises)
    echo(arg type(array[0..0, string]), arg _1) (raises)
  finally:
    =destroy(name _1)
-- end of expandArc ------------------------
--expandArc: sio

scope:
  scope:
    def_cursor filename: string = "debug.txt"
    def_cursor _0: string = filename
    def f: File = open(arg _0, arg fmRead, arg 8000) (raises)
    try:
      scope:
        try:
          def res: string = newStringOfCap(arg 80)
          block L0:
            scope:
              while true:
                scope:
                  def_cursor _1: File = f
                  def _2: bool = readLine(arg _1, name res) (raises)
                  def _3: bool = not(arg _2)
                  if _3:
                    scope:
                      break L0
                  scope:
                    scope:
                      def_cursor x: string = res
                      def_cursor _4: string = x
                      echo(arg type(array[0..0, string]), arg _4) (raises)
        finally:
          =destroy(name res)
    finally:
      scope:
        def_cursor _5: File = f
        close(arg _5) (raises)
-- end of expandArc ------------------------'''
"""

proc main(cond: bool) =
  var x = ("hi", 5) # goal: computed as cursor

  x = if cond:
        ("different", 54)
      else:
        ("string here", 80)

  echo x

main(false)

proc sio =
  for x in lines("debug.txt"):
    echo x

if false:
  sio()
