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

  let create_iter ctx = Bt.Ctf.iter_create ctx C.null C.null

  let get_iter iter = Bt.Ctf.get_iter iter

  let read_event iter = Bt.Ctf.read_event iter

  module Events = struct

    let get_name event = Bt.Ctf.Events.event_name event

  end

end
