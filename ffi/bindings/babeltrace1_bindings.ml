module T = Babeltrace1_types.Struct_stubs(T)

module M(F: Ctypes.FOREIGN) = struct

  module V = Views
  open V

  let foreign = F.foreign

  module C = struct
    include Ctypes
    let (@->)         = F.(@->)
    let returning     = F.returning
  end


  module Format = struct

    type mmap_stream
    type mmap_stream_list
    type format

    let mmap_stream : mmap_stream C.structure C.typ = C.structure "bt_mmap_stream"
    let mmap_stream_list : mmap_stream_list C.structure C.typ = C.structure "bt_mmap_stream_list"
    let format : format C.structure C.typ = C.structure "bt_format"

  end

  module Context = struct

    type context = unit C.ptr
    let context : context C.typ = C.ptr C.void

    type ctf_event = unit C.ptr
    let ctf_event : ctf_event C.typ = C.ptr C.void

    let create =
      foreign ("bt_context_create") C.(void @-> returning context)

    let add_trace =
      foreign ("bt_context_add_trace") C.(context
                                          @-> string
                                          @-> V.format_view
                                          @-> ptr void
                                          @-> ptr void
                                          @-> ptr void
                                          @-> returning int)


    let remove_trace =
      foreign ("bt_context_remove_trace") C.(context
                                             @-> int
                                             @-> returning int)


    let get = foreign ("bt_context_get") C.(context @-> returning void)

    let put = foreign ("bt_context_put") C.(context @-> returning void)

  end

  module Iter = struct

    type iter = unit C.ptr
    let iter : iter C.typ = C.ptr C.void

    type iter_pos = unit C.ptr
    let iter_pos : iter_pos C.typ = C.ptr C.void

    let next =
      foreign ("bt_iter_next") C.(iter @-> returning int)

    let get_pos =
      foreign ("bt_iter_get_pos") C.(iter @-> returning iter_pos)

    let free_pos =
      foreign ("bt_iter_free_pos") C.(iter_pos @-> returning void)

    let set_pos =
      foreign ("bt_iter_set_pos") C.(iter @-> iter_pos @-> returning int)

    let iter_pos =
      foreign ("bt_iter_create_time_pos") C.(iter @-> uint64_t @-> returning iter_pos)

  end

  module Ctf = struct

    type ctf_iter = unit C.ptr
    let ctf_iter : ctf_iter C.typ = C.ptr C.void

    type ctf_event = unit C.ptr
    let ctf_event : ctf_event C.typ = C.ptr C.void

    let iter_create =
      foreign ("bt_ctf_iter_create") C.(Context.context
                                        @-> ptr void
                                        @-> ptr void
                                        @-> returning ctf_iter)

    let get_iter =
      foreign ("bt_ctf_get_iter") C.(ctf_iter @-> returning Iter.iter)

    let iter_destroy =
      foreign ("bt_ctf_iter_destroy") C.(ctf_iter @-> returning void)

    let read_event =
      foreign ("bt_ctf_iter_read_event") C.(ctf_iter @-> returning ctf_event)

    let read_event_flags =
      foreign ("bt_ctf_iter_read_event_flags") C.(ctf_iter @-> ptr int @-> returning ctf_event)

    let get_lost_events_count =
      foreign ("bt_ctf_get_lost_events_count") C.(ctf_iter @-> returning uint64_t)

    module Events = struct

      let event_name =
        foreign ("bt_ctf_event_name") C.(ctf_event @-> returning string_opt)
    end

  end

end
