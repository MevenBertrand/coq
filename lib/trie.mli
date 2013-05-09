(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2012     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(** Generic functorized trie data structure. *)

module type S =
sig
  (** A trie is a generalization of the map data structure where the keys are
      themselves lists. *)

  type label
  (** Keys of the trie structure are [label list]. *)

  type data
  (** Data on nodes of tries are finite sets of [data]. *)

  type t
  (** The trie data structure. Essentially a finite map with keys [label list]
      and content [data Set.t]. *)

  val empty : t
  (** The empty trie. *)

  val get : t -> data list
  (** Get the data at the current node. *)

  val next : t -> label -> t
  (** [next t lbl] returns the subtrie of [t] pointed by [lbl].
      @raise Not_found if there is none. *)

  val labels : t -> label list
  (** Get the list of defined labels at the current node. *)

  val add : label list -> data -> t -> t
  (** [add t path v] adds [v] at path [path] in [t]. *)

  val remove : label list -> data -> t -> t
  (** [remove t path v] removes [v] from path [path] in [t]. *)

  val iter : (label list -> data -> unit) -> t -> unit
  (** Apply a function to all contents. *)

end

module Make (Label : Set.OrderedType) (Data : Set.OrderedType) : S
  with type label = Label.t and type data = Data.t
(** Generating functor, for a given type of labels and data. *)
