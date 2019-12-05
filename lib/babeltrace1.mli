type error = [ `Msg of string ]

type context
type trace_id

val create_context : unit -> (context, error) result
val add_trace : context -> [ `Ctf ] -> string -> (trace_id, error) result
val remove_trace : context -> trace_id -> (unit, error) result

module Iter : sig

  type iter

  val next : iter -> int

end

module Ctf : sig

  type ctf_iter
  type ctf_event
  type ctf_scope = Babeltrace1_types.ctf_scope

  val create_iter : context -> ctf_iter

  val get_iter : ctf_iter -> Iter.iter

  val read_event : ctf_iter -> ctf_event

  module Events : sig

    type event_scope

    val event_name : ctf_event -> string option
    val get_top_level_scope : ctf_event -> ctf_scope -> event_scope
    val get_field_list : ctf_event -> event_scope -> unit

  end

end
