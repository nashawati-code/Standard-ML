(*###############################################################################################################################*)

(* In this programming assignment, you will write your own datatype and use case expressions and pattern matching to traverse it. 
You will also write higher-order functions for traversing your datatype 
and use those higher-order functions with anonymous functions as arguments.  *)

(*===========================================================================================================================*)
(* 1. Write a datatype binding for a type html that can be one of the following: 
    a. Regular text stored as a string
    b. A heading which includes an int indicating the heading number as well as a string with the heading text 
    c. An image which includes two int variables for the width and height of the image 
        as well as a string with the path to the file containing the image 
    d. A list of multiple html objects  *)

datatype html=  regular_text of string 
                | heading of int*string (*int is the head number, and the string is the head text*)
                | image of int*int*string (*width, height, string for the path*)
                | multiple_html_objects of html list; (*list of multiple html objects called html*)

(*===========================================================================================================================*)   
(* 2. Create a value myHTMLPage of type html that stores the following HTML data 
(string arguments to your constructors should not include the HTML tags):   
<h1>My Page</h1>   
This is my page.   
<h2>My Photo</h2>   
This is my photo.   
<img src="photo.jpg" width="400" height="300">   
<h2>My Favorite Programming Language</h2>   
Standard ML.  *)

val myHTMLPage = multiple_html_objects([heading(1,"My Page"), 
                                        regular_text("This is my page."), 
                                        heading(2, "My Photo"),
                                        regular_text("This is my photo."),
                                        image(400,300,"photo.jpg"),
                                        heading(2, "My Favorite Programming Language"),
                                        regular_text("Standard ML.")])

(*===========================================================================================================================*)
(* 3. Write a function printHTML that takes a value of type html and returns a string with the complete html page. 
Use case expressions and pattern matching in your answer. 
Use the operator ^ for concatenating strings and the library function Int.toString for converting an int to a string. 
Do not use higher-order functions.  *)

fun printHTML(myhtml: html) =
    (*this is a case expression*)
    case myhtml of 
        regular_text(stri) => stri
        (*this is pattern matching*)
        | heading(i,stri) => "<h"^Int.toString(i)^">"^stri^"</h"^Int.toString(i)^">"
        | image(w,h,stri) => "<img src ="^stri^" width="^Int.toString(w)^" height="^Int.toString(h)^">"
        | multiple_html_objects(stri) =>    if null stri
                                                then ""
                                            else
                                                printHTML(hd stri)^printHTML(multiple_html_objects(tl stri))    

val print = printHTML(myHTMLPage)

(*===========================================================================================================================*)
(* 4. Write a function countHeadings that takes an integer n and a value of type html and returns the number of level n headings contained. 
Do not bind variables if they are unused. Do not use higherorder functions.  *)

fun countHeadings(n: int, value: html) =
    (*since we are only counting headings, we don't care about the other objects (we set them all to zero)*)
    case value of
        regular_text(stri) => 0
        | heading(i,stri) =>   if n = i
                                    then 1 (*if there is n level headings*)
                                else 0
        | image(w,h,stri) => 0
        | multiple_html_objects(stri) =>    if null stri
                                                then 0 (*because we are returning an int*)
                                            else
                                                n + countHeadings(n, hd stri) + countHeadings(n, multiple_html_objects(tl stri))

val count = countHeadings(1, myHTMLPage)

(*===========================================================================================================================*)
(* 5. Write a function getImagePaths that takes a value of type html and returns a string list containing the paths to all the contained images. 
It is okay to use the operator @ for concatenating two lists (e.g., xs @ ys concatenates the two lists xs and ys).
Do not bind variables if they are unused. 
Do not use higher-order functions.  *)

fun getImagePaths(value: html) =
    (*since we are only getting the image, we don't care about the other objects (we set them all to zero)*)
    case value of
        regular_text(stri) => [] (*since we are return an empty list*)
        | heading(i, stri) => []
        | image(w,h,stri) => [stri] (*string list containing the paths to all the contained images*)
        | multiple_html_objects(stri) =>    if null stri
                                                then []
                                            else
                                                (*operator @ for concatenating two lists*)
                                                getImagePaths(hd stri) @ getImagePaths(multiple_html_objects(tl stri))

val image_path = getImagePaths(myHTMLPage)                     

(*===========================================================================================================================*)
(* 6. Write a higher-order function traverseHTML that takes a function for each variant of your html datatype 
(and a base case for the list variant) and traverses your datatype applying the right function for each variant. 
(Hint: Look at your solutions from questions 3-5 and see what they have in common and where they differ.)  *)

fun traverseHTML(reg, head, img, mult, myHTMLPage, value: html) =
    case value of
        regular_text(stri) => reg(stri)
        | heading(i, stri) => head(i, stri)
        | image(w,h,stri) => img(w,h,stri)
        | multiple_html_objects([]) => myHTMLPage (*a base case for the list variant*)
        | multiple_html_objects(stri) => mult(
                                            traverseHTML(reg, head, img, mult, myHTMLPage, hd stri),
                                            traverseHTML(reg, head, img, mult, myHTMLPage, multiple_html_objects(tl stri))
                                            )

(*===========================================================================================================================*)
(* 7. Write a function printHTML2 that implements printHTML using the higher-order function traverseHTML a
nd pass anonymous functions to it as arguments.  *)

fun printHTML2(value:html) =
    traverseHTML(
                    fn(stri) => printHTML(regular_text(stri)),
                    fn(i, stri) => printHTML(heading(i, stri)),
                    fn(w, h, stri) => printHTML(image(w, h, stri)),
                    fn(i,stri) => i ^ stri,
                    " ", (*this is in the place of myHTMLPage*)
                    value
                )

(*===========================================================================================================================*)
(* 8. Write a function countHeadings2 that implements countHeadings using the higher-order function traverseHTML 
and pass anonymous functions to it as arguments.  *)

fun countHeadings2(n2: int, value2: html) =
    traverseHTML(
                    fn(stri) => 0,
                    fn(i, stri) =>   if n2 = i
                                        then 1 (*if there is n level headings*)
                                    else 0,
                    fn(w, h, stri) => 0,
                    fn(i, stri) => i + stri,
                    0,
                    value2
                )

val count2 = countHeadings2(1, myHTMLPage)

(*===========================================================================================================================*)
(* 9. Write a function getImagePaths2 that implements getImagePaths using the higher-order function traverseHTML 
and pass anonymous functions to it as arguments.  *)

fun getImagePaths2(value2: html) =
    traverseHTML(
                    fn(stri) => [],
                    fn(i, stri) => [],
                    fn(w, h, stri) => [stri],
                    fn(i, stri) => i @ stri, (*operator @ for concatenating two lists*)
                    [],
                    value2
                )

val image_path2 = getImagePaths2(myHTMLPage)                     

(*===========================================================================================================================*)
(*===========================================================================================================================*)
(*

================================== CMD OUTPUT ==================================
datatype html
  = heading of int * string
  | image of int * int * string
  | multiple_html_objects of html list
  | regular_text of string
[autoloading]
[library $SMLNJ-BASIS/basis.cm is stable]
[library $SMLNJ-BASIS/(basis.cm):basis-common.cm is stable]
[autoloading done]
val myHTMLPage =
  multiple_html_objects
    [heading (1,"My Page"),regular_text "This is my page.",
     heading (2,"My Photo"),regular_text "This is my photo.",
     image (400,300,"photo.jpg"),
     heading (2,"My Favorite Programming Language"),
     regular_text "Standard ML."] : html
val printHTML = fn : html -> string
val print =
  "<h1>My Page</h1>This is my page.<h2>My Photo</h2>This is my photo.<img#"
  : string
val countHeadings = fn : int * html -> int
val count = 8 : int
val getImagePaths = fn : html -> string list
val image_path = ["photo.jpg"] : string list
val traverseHTML = fn
  : (string -> 'a) * (int * string -> 'a) * (int * int * string -> 'a) *
    ('a * 'a -> 'a) * 'a * html
    -> 'a
val printHTML2 = fn : html -> string
val countHeadings2 = fn : int * html -> int
val count2 = 1 : int
val getImagePaths2 = fn : html -> string list
val image_path2 = ["photo.jpg"] : string list
val it = () : unit

*)
(*###############################################################################################################################*)
