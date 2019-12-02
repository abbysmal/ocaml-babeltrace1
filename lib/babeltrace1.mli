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

  val create_iter : context -> ctf_iter

  val get_iter : ctf_iter -> Iter.iter

  val read_event : ctf_iter -> ctf_event

  module Events : sig

    val get_name : ctf_event -> string option

  end

end
