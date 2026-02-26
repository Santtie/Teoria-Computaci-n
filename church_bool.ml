(* TRUE = λx.λy.x *)
let true_c = fun x -> fun y -> x

(* FALSE = λx.λy.y *)
let false_c = fun x -> fun y -> y

(* AND = λp.λq. p q false *)
let and_c = fun p -> fun q -> p q false_c

(* OR = λp.λq. p true q *)
let or_c = fun p -> fun q -> p true_c q

(* NOT = λp. p false true *)
let not_c = fun p -> p false_c true_c


(* Helper function to convert Church boolean to OCaml bool *)
let to_bool b = b true false


(* Tests *)
let () =
  print_endline ("true AND true = " ^ string_of_bool (to_bool (and_c true_c true_c)));
  print_endline ("true AND false = " ^ string_of_bool (to_bool (and_c true_c false_c)));
  print_endline ("false AND false = " ^ string_of_bool (to_bool (and_c false_c false_c)));

  print_endline ("true OR false = " ^ string_of_bool (to_bool (or_c true_c false_c)));
  print_endline ("false OR false = " ^ string_of_bool (to_bool (or_c false_c false_c)));

  print_endline ("NOT true = " ^ string_of_bool (to_bool (not_c true_c)));
  print_endline ("NOT false = " ^ string_of_bool (to_bool (not_c false_c)));