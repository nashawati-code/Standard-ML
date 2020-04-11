datatype myType = TwoInts of int * int
                | Str of string
                | Pizza

(* This is a comment *)

val my2ints = TwoInts(3 + 4, let val x::_ = [5, 6, 7] in x end)

val my_str = Str(if true orelse false andalso 89 < 102
                 then "This string has no quotes"
                 else "This string has \"quotes\"")

val myPizza = Pizza

fun f (myVal : myType) =
    case myVal of 
        Pizza => 90 - 53
      | TwoInts(i1,i2) => i1 + i2
      | Str s => String.size s