(*###############################################################################################################################*)

datatype Node = Empty
    | NonEmpty of int * Node * Node 
         
(*===========================================================================================================================*)
(* 
Construct a value myTree of type Node that stores the binary tree. 
*)

val myTree =  NonEmpty(11,NonEmpty(3,Empty,NonEmpty(9,NonEmpty(5,Empty,Empty),NonEmpty(2,Empty,Empty))),
              NonEmpty(7,NonEmpty(4,Empty,Empty),NonEmpty(6,NonEmpty(8,NonEmpty(1,Empty,Empty),
              NonEmpty(10,Empty,Empty)),Empty)));

(*===========================================================================================================================*)
(* 
Write a function treeSum that takes a value of type Node 
and returns the sum of all the integers stored in the nodes of the tree rooted at that node.  
*)

fun treeSum (rootNode: Node) =
case rootNode of
		Empty => 0
	|	NonEmpty(num, Left, Right) => num + treeSum(Left) + treeSum(Right)

val sum = treeSum(myTree)

(*===========================================================================================================================*)
(* 
Write a function treeSize that takes a value of type Node 
and returns the total number of nodes in the tree rooted at that node.  
*)

fun treeSize (rootNode: Node) =
case rootNode of
		Empty => 0
	|	NonEmpty(root,Left,Right) => 1 + treeSize(Left) + treeSize(Right)

val size = treeSize(myTree)

(*===========================================================================================================================*)
(*
Write a function numGreaterThan that takes a value of type Node and an integer n 
and returns the total number of nodes holding a value greater than n. 
*)

fun numGreaterThan (rootNode: Node, n: int) =
case rootNode of
		Empty => 0
	|	NonEmpty(root,Left,Right) => 	if n < root 
    							then 1 + numGreaterThan(Left,n) + numGreaterThan(Right,n) 
  						else numGreaterThan(Left,n) + numGreaterThan(Right,n)
	
val n = treeSum(myTree);
val greater = numGreaterThan(myTree, 6)

(*===========================================================================================================================*)
(*
Write a function numLeaves that takes a value of type Node 
and returns the total number of leaves in the tree rooted at that node 
(hint: use nested pattern matching). 
*)

fun numLeaves (rootNode: Node) =
case rootNode of
	Empty => 0
    |	NonEmpty(root,Empty,Empty) => 1
    |	NonEmpty(root,Left,Right) => numLeaves(Left) + numLeaves(Right)

val leaves = numLeaves(myTree)

(*===========================================================================================================================*)
(*
Write a function numNoRightChild that takes a value of type Node 
and returns the total number of non-NonEmpty nodes with no right child in the tree rooted at that node 
(hint: use nested pattern matching).
*)

fun numNoRightChild (rootNode: Node) =
case rootNode of
	Empty => 0
    |	NonEmpty(root,Empty,Empty) => 0
    |	NonEmpty(root,Left,Empty) => 1
    |   NonEmpty(root, Left, Right) => numNoRightChild(Left) + numNoRightChild(Right)

val no_right = numNoRightChild(myTree)

(*===========================================================================================================================*)
(*
Write a higher-order function traverseTree to traverse the binary tree. 
The function should take a value of type Node, 
a value to return for the Empty variant, 
and a function to process the NonEmpty variant. 
*)

fun traverseTree (rootNode: Node, empty_value, process_function) =
case rootNode of
        Empty => empty_value
    |   NonEmpty(root,Left,Right) => process_function(traverseTree(Left, empty_value, process_function),
                                                        traverseTree(Right, empty_value, process_function),
                                                        root)

(*===========================================================================================================================*)
(*
Write a function treeSum2 that implements treeSum using the higher-order function traverseTree 
and pass anonymous functions to it as arguments. 
*)

fun treeSum2 (rootNode: Node) =
    let 
    	val funct = fn anon => case anon of (x,y,z) => x+y+z
    in
        traverseTree(rootNode, 0, funct )
    end

val sum2 = treeSum2(myTree)

(*===========================================================================================================================*)
(*
Write a function numGreaterThan2 that implements numGreaterThan using the higherorder function traverseTree 
and pass anonymous functions to it as arguments.
*)

fun numGreaterThan2 (rootNode: Node, n2:int) =
    let 
    	val funct = fn anon2 => case anon2 of (x,y,z) => x+y+z
    in
        traverseTree(rootNode, 0, funct )
    end

val n2 = treeSum(myTree);
val greater2 = numGreaterThan(myTree, 6)

(*===========================================================================================================================*)
(*
This question is unrelated to questions 1-9. 
The following function sumOfProducts 
computes the logical sum of products for a set of minterms stored as a list of pairs of booleans. 

fun sumOfProducts lst =     
    case lst of         
        [] => false       
        | (x, y)::lst' => x andalso y orelse sumOfProducts(lst') 

Rewrite this function to perform the same operation but implemented using tail recursion. 
Do no use the built-in fold function. 
*)

fun sumOfProducts lst =     
    case lst of         
        [] => false       
        | (x, y)::lst' => x andalso y orelse sumOfProducts(lst') 


fun sumOfProducts nil = 0
| sumOfProducts (x::xs) = x + sumOfProducts xs

(*===========================================================================================================================*)
(*

================================== CMD OUTPUT ==================================
datatype Node = Empty | NonEmpty of int * Node * Node
val myTree =
  NonEmpty
    (11,NonEmpty (3,Empty,NonEmpty #),NonEmpty (7,NonEmpty #,NonEmpty #))
  : Node
val treeSum = fn : Node -> int
val sum = 66 : int
val treeSize = fn : Node -> int
val size = 11 : int
val numGreaterThan = fn : Node * int -> int
val n = 66 : int
val greater = 5 : int
val numLeaves = fn : Node -> int
val leaves = 5 : int
val numNoRightChild = fn : Node -> int
val no_right = 1 : int
val traverseTree = fn : Node * 'a * ('a * 'a * int -> 'a) -> 'a
val treeSum2 = fn : Node -> int
val sum2 = 66 : int
val numGreaterThan2 = fn : Node * int -> int
val n2 = 66 : int
val greater2 = 5 : int
val sumOfProducts = <hidden-value> : (bool * bool) list -> bool
val sumOfProducts = fn : int list -> int
val it = () : unit

*)
(*###############################################################################################################################*)
