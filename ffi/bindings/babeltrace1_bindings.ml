
module M(F: Ctypes.FOREIGN) = struct

  module T = Babeltrace1_types.Struct_stubs(T)

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

    type definition = unit C.ptr
    let definition : definition C.typ = C.ptr C.void

    type declaration  = unit C.ptr
    let declaration : declaration C.typ = C.ptr C.void

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

    type ctf_field_decl = unit C.ptr
    let ctf_field_decl : ctf_field_decl C.typ = C.ptr C.void

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

      let get_top_level_scope =
        foreign ("bt_ctf_get_top_level_scope") C.(ctf_event @-> T.ctf_scope @-> returning Context.definition)

      let event_name =
        foreign ("bt_ctf_event_name") C.(ctf_event @-> returning string_opt)

      let get_cycles =
        foreign ("bt_ctf_get_cycles") C.(ctf_event @-> returning uint64_t)

      let get_timestamp =
        foreign ("bt_ctf_get_timestamp") C.(ctf_event @-> returning uint64_t)

      let get_field_list =
        foreign ("bt_ctf_get_field_list") C.(ctf_event
                                             @-> Context.definition
                                             @-> (ptr  (ptr Context.definition))
                                             @-> (ptr uint)
                                             @-> returning void)

      let get_field =
        foreign ("bt_ctf_get_field") C.(ctf_event
                                        @-> Context.definition
                                        @-> string
                                        @-> returning Context.definition)

      let get_index =
        foreign ("bt_ctf_get_index") C.(ctf_event
                                        @-> Context.definition
                                        @-> uint
                                        @-> returning Context.definition)

      let field_name =
        foreign ("bt_ctf_field_name") C.(Context.definition @-> returning string)

      let get_decl_from_def =
        foreign ("bt_ctf_get_decl_from_def") C.(Context.definition @-> returning ctf_field_decl)

      let get_decl_from_field_decl =
        foreign ("bt_ctf_get_decl_from_field_decl") C.(ctf_field_decl @-> returning Context.declaration)

      let field_type =
        foreign ("bt_ctf_field_type") C.(Context.declaration
                                             @-> returning T.ctf_type_id)

      let get_int_signedness =
        foreign ("bt_ctf_get_int_signedness") C.(Context.declaration
                                                 @-> returning int)

      let get_int_base =
        foreign ("bt_ctf_get_int_base") C.(Context.declaration
                                                 @-> returning int)

      let get_int_byte_order =
        foreign ("bt_ctf_get_int_byte_order") C.(Context.declaration
                                                 @-> returning int)

      let get_int_len =
        foreign ("bt_ctf_get_int_len") C.(Context.declaration
                                          @-> returning int)


      let get_encoding =
        foreign ("bt_ctf_get_encoding") C.(Context.declaration
                                           @-> returning T.ctf_string_encoding)

      let get_array_len =
        foreign ("bt_ctf_get_array_len") C.(Context.declaration
                                            @-> returning int)

      let get_struct_field_count =
        foreign ("bt_ctf_get_struct_field_count") C.(Context.definition
                                                     @-> returning uint64_t)

      let get_uint64 =
        foreign ("bt_ctf_get_uint64") C.(Context.definition @-> returning uint64_t)

      let get_int64 =
        foreign ("bt_ctf_get_int64") C.(Context.definition @-> returning int64_t)

      let get_enum_int =
        foreign ("bt_ctf_get_enum_int") C.(Context.definition @-> returning Context.definition)

      let get_enum_str =
        foreign ("bt_ctf_get_enum_str") C.(Context.definition @-> returning string)

      let get_char_array =
        foreign ("bt_ctf_get_char_array") C.(Context.definition @-> returning (ptr char))

      let get_string =
        foreign ("bt_ctf_get_string") C.(Context.definition @-> returning string)

      let get_float =
        foreign ("bt_ctf_get_float") C.(Context.definition @-> returning double)

      let get_variant =
        foreign ("bt_ctf_get_variant") C.(Context.definition @-> returning Context.definition)

      let get_struct_field_index =
        foreign ("bt_ctf_get_struct_field_index") C.(Context.definition @-> uint64_t @-> returning Context.definition)

      let field_get_error =
        foreign ("bt_ctf_field_get_error") C.(void @-> returning int)
    end

  end

end
