discard """
  output: ''''''
  cmd: '''nim c --gc:arc --expandArc:traverse --hint:Performance:off $file'''
  nimout: '''--expandArc: traverse

scope:
  def_cursor it: Node = root
  block L0:
    scope:
      while true:
        scope:
          def_cursor _0: Node = it
          def _1: bool = eqRef(arg _0, arg nil)
          def _2: bool = not(arg _1)
          def _3: bool = not(arg _2)
          if _3:
            scope:
              break L0
          scope:
            def_cursor _4: Node = it
            def_cursor _5: string = _4[].s
            echo(arg type(array[0..0, string]), arg _5) (raises)
            def_cursor _6: Node = it
            it = _6[].ri
  def_cursor jt: Node = root
  block L1:
    scope:
      while true:
        scope:
          def_cursor _7: Node = jt
          def _8: bool = eqRef(arg _7, arg nil)
          def _9: bool = not(arg _8)
          def _10: bool = not(arg _9)
          if _10:
            scope:
              break L1
          scope:
            def_cursor _11: Node = jt
            def_cursor ri: Node = _11[].ri
            def_cursor _12: Node = jt
            def_cursor _13: string = _12[].s
            echo(arg type(array[0..0, string]), arg _13) (raises)
            jt = ri
-- end of expandArc ------------------------'''
"""

type
  Node = ref object
    le, ri: Node
    s: string

proc traverse(root: Node) =
  var it = root
  while it != nil:
    echo it.s
    it = it.ri

  var jt = root
  while jt != nil:
    let ri = jt.ri
    echo jt.s
    jt = ri

traverse(nil)

# XXX: This optimization is not sound
