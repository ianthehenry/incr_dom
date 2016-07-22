open! Core_kernel.Std
open! Import

module Model : sig
  type t [@@deriving sexp]

  val example : unit -> t
  val kick : t -> t
  val move_focus : t -> Focus_point.t option -> focus_dir -> Focus_point.t option
  val set_visibility : t -> bool -> t
  val is_visible : t -> bool
  val name : t -> string
end

module Action : sig
  type t =
    | Bump of bump_dir
    | Toggle_collapse
  [@@deriving sexp]

  (** Note that apply should be passed the focus point at the time the action was
      initiated. *)
  val apply : t -> Focus_point.t option -> Model.t -> Model.t
end

type focus_state = Unfocused | Focused of Focus_point.t option

val view
  :  Model.t Incr.t
  -> Entry_id.t
  -> focus:focus_state Incr.t
  -> focus_me:(unit -> unit)
  -> set_inner_focus:(Focus_point.t -> unit)
  -> Vdom.Node.t Incr.t
