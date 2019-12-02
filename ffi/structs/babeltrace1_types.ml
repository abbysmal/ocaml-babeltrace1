type ctf_scope =
    Trace_packet_header
  | Stream_packet_context
  | Stream_event_header
  | Stream_event_context
  | Event_context
  | Event_fields

type ctf_type_id =
  Ctf_type_unknown
| Ctf_type_integer
| Ctf_type_float
| Ctf_type_enum
| Ctf_type_string
| Ctf_type_struct
| Ctf_type_untagged_variant
| Ctf_type_variant
| Ctf_type_array
| Ctf_type_sequence
| Nr_ctf_types

type ctf_string_encoding =
    Ctf_string_none
  | Ctf_string_utf8
  | Ctf_string_ascii
  | Ctf_string_unknown

module Struct_stubs(S : Ctypes.TYPE) = struct

  let trace_packet_header = S.constant "BT_TRACE_PACKET_HEADER" S.int64_t
  let stream_packet_context = S.constant "BT_STREAM_PACKET_CONTEXT" S.int64_t
  let stream_event_header = S.constant "BT_STREAM_EVENT_HEADER" S.int64_t
  let stream_event_context = S.constant "BT_STREAM_EVENT_CONTEXT" S.int64_t
  let event_context = S.constant "BT_EVENT_CONTEXT" S.int64_t
  let event_fields = S.constant "BT_EVENT_FIELDS" S.int64_t

  let ctf_scope = S.enum "bt_ctf_scope" [
      Trace_packet_header, trace_packet_header;
      Stream_packet_context, stream_packet_context;
      Stream_event_header, stream_event_header;
      Stream_event_context, stream_event_context;
      Event_context, event_context;
      Event_fields, event_fields
    ] ~unexpected:(fun _ -> assert false)

  let type_unknown = S.constant "CTF_TYPE_UNKNOWN" S.int64_t
  let type_integer = S.constant	"CTF_TYPE_INTEGER" S.int64_t
  let type_float = S.constant "CTF_TYPE_FLOAT" S.int64_t
  let type_enum = S.constant "CTF_TYPE_ENUM" S.int64_t
  let type_string = S.constant "CTF_TYPE_STRING" S.int64_t
  let type_struct = S.constant "CTF_TYPE_STRUCT" S.int64_t
  let type_untagged_variant = S.constant "CTF_TYPE_UNTAGGED_VARIANT" S.int64_t
  let type_variant = S.constant "CTF_TYPE_VARIANT" S.int64_t
  let type_array = S.constant "CTF_TYPE_ARRAY" S.int64_t
  let type_sequence = S.constant "CTF_TYPE_SEQUENCE" S.int64_t
  let nr_ctf_types = S.constant "NR_CTF_TYPES" S.int64_t

  let ctf_type_id = S.enum "ctf_type_id" [
      Ctf_type_unknown, type_unknown
    ; Ctf_type_integer, type_integer
    ; Ctf_type_float, type_float
    ; Ctf_type_enum, type_enum
    ; Ctf_type_string, type_string
    ; Ctf_type_struct, type_struct
    ; Ctf_type_untagged_variant, type_untagged_variant
    ; Ctf_type_variant, type_variant
    ; Ctf_type_array, type_array
    ; Ctf_type_sequence, type_sequence
    ; Nr_ctf_types, nr_ctf_types
    ] ~unexpected:(fun _ -> assert false)

  let ctf_string_none = S.constant "CTF_STRING_NONE" S.int64_t
  let ctf_string_utf8 = S.constant "CTF_STRING_UTF8" S.int64_t
  let ctf_string_ascii = S.constant "CTF_STRING_ASCII" S.int64_t
  let ctf_string_unknown = S.constant "CTF_STRING_UNKNOWN" S.int64_t

  let ctf_string_encoding = S.enum "ctf_string_encoding" [
      Ctf_string_none, ctf_string_none;
      Ctf_string_utf8, ctf_string_utf8;
      Ctf_string_ascii, ctf_string_ascii;
      Ctf_string_unknown, ctf_string_unknown;
    ] ~unexpected:(fun _ -> assert false)

end
