module Bt = Babeltrace1_ffi.M
module C = Ctypes

type error = [ `Msg of string ]
let msg s = Error (`Msg s)

type context = Bt.Context.context
type trace_id = int

let create_context () =
  let ctx = Bt.Context.create () in
  match C.is_null ctx with
  | true -> msg "create_context: returned NULL"
  | false -> Ok ctx

let add_trace ctx format path =
  let trace_id = Bt.Context.add_trace ctx path format C.null C.null C.null in
  if trace_id < 0 then
    msg "add_trace"
  else
    Ok trace_id

let remove_trace ctx trace_id =
  let result = Bt.Context.remove_trace ctx trace_id in
  if result < 0 then
    msg "remove_trace"
  else
    Ok ()

module Iter = struct

  type iter = Bt.Iter.iter

  let next iter = Bt.Iter.next iter

end

module Ctf = struct

  type ctf_iter = Bt.Ctf.ctf_iter
  type ctf_event = Bt.Ctf.ctf_event
  type ctf_scope = Babeltrace1_types.ctf_scope

  let create_iter ctx = Bt.Ctf.iter_create ctx C.null C.null

  let get_iter iter = Bt.Ctf.get_iter iter

  let read_event iter = Bt.Ctf.read_event iter

  module Events = struct

    module E = Bt.Ctf.Events

    type event_scope = Bt.Context.definition

    let event_name  = E.event_name

    let get_top_level_scope = E.get_top_level_scope

    let get_field_list event scope =
      let i = Unsigned.UInt.zero in
      let i = C.(allocate uint i) in
      let p = C.(allocate Bt.Context.definition null) in
      let pp = C.(allocate (ptr Bt.Context.definition) p) in
      E.get_field_list event scope pp i

  end

end
