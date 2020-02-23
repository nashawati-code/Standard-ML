(*###############################################################################################################################*)
(*===========================================================================================================================*)
(*Sum of all list elements*)
fun sum_list(integer_list: int list) =
    if null integer_list
        then 0
    else
        (hd integer_list) + sum_list(tl integer_list)

val sumtest = sum_list([~1,2,3,5])

(*===========================================================================================================================*)
(*Multiply of all list elements*)
fun mult_list(integer_list: int list) =
    if null integer_list
        then 1
    else
        (hd integer_list) * mult_list(tl integer_list)

val multtest = mult_list([3,4,9,1,2])

(*===========================================================================================================================*)
(*Generate and return a list of a requested size*)
fun printlistofsize(size: int) =
    if size <= 0
        then []
    else
        size :: printlistofsize(size - 1)

val sizetest = printlistofsize(8)

(*===========================================================================================================================*)
(*Append one list to another*)
fun append_list(list1: int list, list2: int list) =
    if null list2
        then list1
    else
        (hd list2) :: append_list(list1, tl list2)
    
val append = append_list(printlistofsize(3), printlistofsize(4))

(*===========================================================================================================================*)
(*Sum of pair of list*)
fun sum_list(list: (int*int)list) =
    if null list
        then 0
    else
        #1(hd list) + #2(hd list) + sum_list(tl list)

val sum = sum_list([(1,3),(2,1),(3,6)])

(*===========================================================================================================================*)
(*Prints a list of the first element*)
fun print_first(list: (int*int*int)list) =
    if null list
        then []
    else
        #1(hd list) :: print_first(tl list)

val first = print_first([(1,3,2),(2,1,5),(3,6,8)])

(*===========================================================================================================================*)
(*Prints a list of the second element*)
fun print_second(list: (int*int*int)list) =
    if null list
        then []
    else
        #2(hd list) :: print_second(tl list)

val second = print_second([(1,3,2),(2,1,5),(3,6,8)])

(*===========================================================================================================================*)
(*Prints a list of the third element*)
fun print_third(list: (int*int*int)list) =
    if null list
        then []
    else
        #3(hd list) :: print_third(tl list)

val third = print_third([(1,3,2),(2,1,5),(3,6,8)])

(*===========================================================================================================================*)
(*

================================== CMD OUTPUT ==================================
val sum_list = <hidden-value> : int list -> int
val sumtest = 9 : int
val mult_list = fn : int list -> int
val multtest = 216 : int
val printlistofsize = fn : int -> int list
val sizetest = [8,7,6,5,4,3,2,1] : int list
val append_list = fn : int list * int list -> int list
val append = [4,3,2,1,3,2,1] : int list
val sum_list = fn : (int * int) list -> int
val sum = 16 : int
val print_first = fn : (int * int * int) list -> int list
val first = [1,2,3] : int list
val print_second = fn : (int * int * int) list -> int list
val second = [3,1,6] : int list
val print_third = fn : (int * int * int) list -> int list
val third = [2,5,8] : int list
val it = () : unit

*)
(*###############################################################################################################################*)
