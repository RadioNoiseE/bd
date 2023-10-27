type struct =
  | Integer of int
  | Float of float
  | String of string
  | Array of struct list
  | Bool of bool
  | Object of (string * struct) list
  | Null

/* Obsolete |=>
type value =
  [ `Assoc of (string * value) list
  | `Bool of bool
  | `Float of float
  | `Int of int
  | `List of value list
  | `Null
  | `String of string ]
<=| */
