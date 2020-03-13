(*===========================================================================================================================*)
(*
Write a function rgb2gray that takes an RGB pixel and returns a grayscale pixel. 
To convert from RGB to grayscale, 
multiply the red component by 3, 
the green component by 6, 
and the blue component by 1, 
and then add them and divide by 10. 
*)

fun rgb2gray(r:int, g:int, b:int)=
    (3*r + 6*g + 1*b)div 10

val gray = rgb2gray(8,7,6)

(*===========================================================================================================================*)
(*
Write a function isBrighter that takes two RGB pixels 
and returns true if the first pixel is brighter than the second pixel and false otherwise. 
To check if an RGB pixel is brighter than another RGB pixel, convert them both to grayscale (use rgb2gray), 
and check which ones has the higher grayscale value.
*)

fun isBrighter(pixel1: int*int*int, pixel2: int*int*int)=
    rgb2gray((#1 pixel1) , (#2 pixel1), (#3 pixel1)) > rgb2gray((#1 pixel2) , (#2 pixel2), (#3 pixel2))

val light = isBrighter((2,2,8),(4,5,9))

(*===========================================================================================================================*)
(*
Write a function rgb2grayImage that takes an RGB image image and returns a grayscale image (use rgb2gray).
*)

fun rgb2grayImage(image: (int*int*int)list)=
    if null image
    then []
    else 
        rgb2gray(hd image) :: rgb2grayImage(tl image)

val newImage = rgb2grayImage([(1,2,3),(5,6,7),(0,5,7),(7,4,3)])

(*===========================================================================================================================*)
(*
Write a function getPixel that takes an RGB image image and an integer i and returns the ith pixel in the image. 
Assume the first pixel has index 0. Do not worry about the case where the list has too few elements. 
*)

fun getPixel(image: (int*int*int)list, i:int)=
    if i=0
    then hd image
    else 
        getPixel(tl image, i-1)

val pixel = getPixel([(1,2,3),(5,6,7),(0,5,7),(7,4,3)] ,3)

(*===========================================================================================================================*)
(*
Write a function shrinkImage that takes a grayscale image 
and shrinks it horizontally in half by converting every two consecutive pixels 
to a single pixel whose value is the average of the two original pixels. 
Assume the image has an even width.
*)

fun shrinkImage(image: int list)=
    if null image
    then []
    else
        ((hd image + hd(tl image))div 2) :: shrinkImage(tl (tl image));

(*===========================================================================================================================*)
(*
Write a function countRedPixels that takes an RGB image 
and returns the number of pixels where the red component is higher than the green and blue components.
*)

fun countRedPixels(image: (int*int*int)list)=
    if null image
    then 0
    else   
        if(#1(hd image) > #2(hd image)) andalso (#1(hd image) > #3(hd image))
        then 1 + countRedPixels(tl image)
        else countRedPixels(tl image)

(*===========================================================================================================================*)
(* 
Write a function getGreenPixels that takes an RGB image 
and returns a list of pixels where the green component is higher than the red and blue components. *)

fun getGreenPixels(image: (int*int*int)list)=
    if null image
    then []
    else
        if(#1(hd image) < #2(hd image)) andalso (#2(hd image) < #3(hd image))
        then (hd image) :: getGreenPixels(tl image)
        else getGreenPixels(tl image)

(*===========================================================================================================================*)
(* Write a function getPixelsInBlueRange that takes an RGB image
and a pair range and returns a list of pixels whose blue component is in between #1 range and #2 range (exclusive).  *)

fun getPixelsInBlueRange(image: (int*int*int)list, range: (int*int))=
    if null image
    then []
    else
        if(#1(hd image) < #3(hd image)) andalso (#3(hd image) < #2(hd image))
        then (hd image) :: getPixelsInBlueRange(tl image, range)
        else getPixelsInBlueRange(tl image, range)

(*===========================================================================================================================*)
(* 
Write a function countPixelsInBlueRanges that takes an RGB image
and a list of pairs ranges and returns the number of pixels where the blue component is in one of the ranges in ranges. *)

fun countPixelsInBlueRanges(image: (int*int*int)list, range: (int*int)list)=
    if null image
    then 0
    else   
        if(#1(hd image) > #2(hd image)) andalso (#1(hd image) > #3(hd image))
        then 1 + countPixelsInBlueRanges(tl image, range)
        else countPixelsInBlueRanges(tl image, range)

(*===========================================================================================================================*)
(* 
Write a function brightest that takes an RGB image and returns the brightest pixel in the image (use isBrighter). 
Assume the image always has at least one pixel (do not check for the case when the list of pixels is empty).  *)
 
 fun brightest(image: (int*int*int)list)=
    if null (tl image)
    then hd image
    else
        let val bright = brightest(tl image)
        in
            if isBrighter(hd image, bright)
            then hd image
            else bright
        end

(*===========================================================================================================================*)
(*

================================== CMD OUTPUT ==================================
val rgb2gray = fn : int * int * int -> int
val gray = 7 : int
val isBrighter = fn : (int * int * int) * (int * int * int) -> bool
val light = false : bool
val rgb2grayImage = fn : (int * int * int) list -> int list
val newImage = [1,5,3,4] : int list
val getPixel = fn : (int * int * int) list * int -> int * int * int
val pixel = (7,4,3) : int * int * int
val shrinkImage = fn : int list -> int list
val countRedPixels = fn : (int * int * int) list -> int
val getGreenPixels = fn : (int * int * int) list -> (int * int * int) list
val getPixelsInBlueRange = fn
  : (int * int * int) list * (int * int) -> (int * int * int) list
val countPixelsInBlueRanges = fn
  : (int * int * int) list * (int * int) list -> int
val brightest = fn : (int * int * int) list -> int * int * int
val it = () : unit

*)
(*===========================================================================================================================*)
