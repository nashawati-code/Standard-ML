(*###############################################################################################################################*)
(*
In this programming assignment, you will write functions in SML related to dates. A date is represented
as a 3-tuple where the first element is an integer representing the day, the second element is an integer
representing the month, and the third element is an integer representing the year. The type of a date is
therefore int*int*int. You can assume that all dates have valid values and do not need to check for their
validity in your code.
*)    
(*===========================================================================================================================*)
(*
1. Write a function is_older that takes two dates and evaluates to true if the first argument is a
date that comes before the second argument. (If the two dates are the same, the result is false.)
*)

fun is_older(date1: int*int*int, date2: int*int*int) =
    if (#1 date1) = (#2 date1)
    then
        if (#2 date1) = (#2 date2) 
            then (#3 date1) < (#3 date2)
        else (#2 date1) < (#2 date2)
    else
        (#1 date1) < (#1 date2)

val compare = is_older((9,8,17),(3,4,17))

(*===========================================================================================================================*)
(*
2. Write a function number_in_month that takes a list of dates and a month (i.e., an int) and
returns how many dates in the list are in the given month.
*)

fun number_in_month(dates: (int*int*int)list, month:int) =
    (*we are returing 0 since we want a number not a list*)
    if null dates 
        then 0
    else
        (*always write hd*)
        if #2(hd dates) = month
            (*the parameters are usually tl*)
            then 1 + number_in_month(tl dates, month)
        else
            (*the parameters are usually tl*)
            number_in_month(tl dates, month)

val num_month = number_in_month([(3,4,18),(1,4,13),(5,6,17)],4)

(*===========================================================================================================================*)
(*
3. Write a function number_in_months that takes a list of dates and a list of months (i.e., an int
list) and returns the number of dates in the list of dates that are in any of the months in the list
of months. Assume the list of months has no number repeated. Hint: Use your answer to the
previous problem.
*)

fun number_in_months(dates: (int*int*int)list, months: int list) =
    (*we are returing 0 since we want a number not a list*)
    if null months
        then 0
    else
        number_in_month(dates, hd months) + number_in_months(dates, tl months)

val num_months = number_in_months([(3,4,18),(1,4,13),(5,6,17)],[4])

(*===========================================================================================================================*)
(*
4. Write a function dates_in_month that takes a list of dates and a month (i.e., an int) and
returns a list holding the dates from the argument list of dates that are in the month. The returned
list should contain dates in the order they were originally given.
*)

fun dates_in_month(dates: (int*int*int)list, month:int) =
    if null dates
        then []
    else
        if #2(hd dates) = month
            then hd dates :: dates_in_month(tl dates, month)
        else
            dates_in_month(tl dates, month)

val check_dates = dates_in_month([(1,6,13),(5,6,17),(3,5,17),(7,4,13)], 6)

(*===========================================================================================================================*)
(*
5. Write a function get_nth that takes a list of strings and an int n and returns the n
th element
of the list (the head of the list is considered the 1st element).
Do not worry about the case where the list has too few elements.
*)

fun get_nth(strings: string list, n: int) =
    if n = 1
        then hd strings
    else
        get_nth(tl strings, n-1)

val nth = get_nth(["hello", "i", "am", "trying", "my", "best"], 4)

(*===========================================================================================================================*)
(*
6. Write a function date_to_string that takes a date and returns a string representation of the
date of the form “January 28, 2019” (for example). You can use the operator ^ for concatenating
strings and the library function Int.toString for converting an int to a string. For producing
the month part, do not use a bunch of conditionals. Instead, use a list holding 12 strings and your
answer to the previous problem. Make sure to use the format specified exactly.
*)

fun date_to_string(date: int*int*int) =
    let
        val months = ["January", "February", "March", "April", "May", "June", "July",
                        "August", "September", "October", "November", "December"]
    in
        get_nth(months, #2 date)
        ^ " " ^ Int.toString(#1 date)
        ^ ", " ^ Int.toString(#3 date)
    end

val strings = date_to_string((28,1,2019))

(*===========================================================================================================================*)
(*
7. Write a function number_before_reaching that takes an int called target, which you can
assume is positive, and an int list, which you can assume contains all positive numbers, and
returns an int. You should return an int n such that the first n-1 elements of the list add to less
than target, but the first n elements of the list add to target or more. Assume the entire list sums
to more than the target.
*)

fun number_before_reaching(target: int, numbers: int list) =    
    let
        val new_target = target - hd numbers
    in
        if new_target > 0
            then 1 + number_before_reaching(new_target, tl numbers)
        else 0
    end

val before_reaching = number_before_reaching(16,[20])

(*===========================================================================================================================*)
(*
8. Write a function what_month that takes a day of year (i.e., an int between 1 and 365) and
returns what month that day is in (1 for January, 2 for February, etc.). Use a list holding 12 integers
and your answer to the previous problem.
*)

fun what_month(day: int) =
    let
        val days_in_a_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching(day, days_in_a_month) + 1
    end

val what = what_month(24)


(*===========================================================================================================================*)
(*
9. Write a function month_range that takes two days of the year day1 and day2 and returns an
int list with all the months from day1 to day2.
*)

fun month_range(day1: int, day2: int) =
	let
		val difference = day2 - day1
	in
		if difference < 0
		    then []
		else what_month(day1) :: month_range((day1 +1), day2)
	end

val range = month_range(74,299)

(*===========================================================================================================================*)
(*
10. Write a function oldest that takes a list of dates and returns the oldest date in the list. Assume
the list always has at least one element (do not check for the case when the list is empty).
*)
(*===========================================================================================================================*)

fun oldest(dates: (int*int*int)list) =
    if null dates 
        then NONE
    else 
        let
            val tl_ans = oldest(tl dates)
        in
            if isSome tl_ans andalso is_older(valOf tl_ans, hd dates) 
                then tl_ans
            else 
                SOME (hd dates)
        end

val older = oldest([(28,1,2019),(2,3,1999)])

(*===========================================================================================================================*)
(*

================================== CMD OUTPUT ==================================

val is_older = fn : (int * int * int) * (int * int * int) -> bool
val compare = false : bool
val number_in_month = fn : (int * int * int) list * int -> int
val num_month = 2 : int
val number_in_months = fn : (int * int * int) list * int list -> int
val num_months = 2 : int
val dates_in_month = fn
  : (int * int * int) list * int -> (int * int * int) list
val check_dates = [(1,6,13),(5,6,17)] : (int * int * int) list
val get_nth = fn : string list * int -> string
val nth = "trying" : string
val date_to_string = fn : int * int * int -> string
val strings = "January 28, 2019" : string
val number_before_reaching = fn : int * int list -> int
val before_reaching = 0 : int
val what_month = fn : int -> int
val what = 1 : int
val month_range = fn : int * int -> int list
val range = [3,3,3,3,3,3,3,3,3,3,3,3,...] : int list
val oldest = fn : (int * int * int) list -> (int * int * int) option
val older = SOME (2,3,1999) : (int * int * int) option
val it = () : unit

*)
(*===========================================================================================================================*)

(*###############################################################################################################################*)
