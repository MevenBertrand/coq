
(* $Id$ *)

(*i*)
open Names
open Term
open Sign
open Evd
open Environ
open Reduction
(*i*)

(* This modules provides useful functions for unification algorithms.
 * Used in Trad and Progmach.
 * This interface will have to be improved. *)

val filter_unique : 'a list -> 'a list
val distinct_id_list : identifier list -> identifier list

val filter_sign :
  ('a -> identifier * typed_type -> bool * 'a) -> var_context -> 'a ->
  'a * identifier list * var_context

val dummy_sort : constr
val do_restrict_hyps : 'a evar_map -> constr -> 'a evar_map * constr
val has_ise : 'a evar_map -> constr -> bool

type 'a evar_defs = 'a evar_map ref

val ise_try : 'a evar_defs -> (unit -> bool) list -> bool

val ise_undefined : 'a evar_defs -> constr -> bool
val ise_defined : 'a evar_defs -> constr -> bool

val real_clean :
  'a evar_defs -> int -> (identifier * constr) list -> constr -> constr
val new_isevar :
  'a evar_defs -> env -> constr -> path_kind -> constr
val evar_define : 'a evar_defs -> constr -> constr -> int list
val solve_simple_eqn : (constr -> constr -> bool) -> 'a evar_defs ->
  (conv_pb * constr * constr) -> int list option

val has_undefined_isevars : 'a evar_defs -> constr -> bool
val head_is_exist : 'a evar_defs -> constr -> bool
val is_eliminator : constr -> bool
val head_is_embedded_exist : 'a evar_defs -> constr -> bool
val head_evar : constr -> int
val status_changed : int list -> conv_pb * constr * constr -> bool


(* Value/Type constraints *)

type type_constraint = constr option
type val_constraint = constr option

val empty_tycon : type_constraint
val mk_tycon : constr -> type_constraint

val empty_valcon : val_constraint
val mk_valcon : constr -> val_constraint

val split_tycon :
  Rawterm.loc -> env -> 'a evar_defs -> type_constraint -> 
    type_constraint * type_constraint

val valcon_of_tycon : type_constraint -> val_constraint

(* $Id$ *)
