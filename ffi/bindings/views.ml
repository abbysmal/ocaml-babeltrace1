open Ctypes

let bool_to_uchar =
  let open Unsigned in
  view
    ~read:(fun u -> u <> UChar.zero)
    ~write:(function true -> UChar.one | false -> UChar.zero)
    uchar

let bool_to_int =
  view
    ~read:(fun u -> u <> 0)
    ~write:(function true -> 1 | false -> 0)
    int

let string_of_format = function `Ctf -> "ctf"

let format_view =
  let read = fun s ->
    if String.equal s "ctf" then
      `Ctf
    else
    invalid_arg @@ Printf.sprintf "compression_view: unsupported trace format: %s" s
  in
  let write = string_of_format in
  Ctypes.view ~read ~write Ctypes.string

let int_to_uint64 =
  let open Unsigned in
  view ~write:UInt64.of_int ~read:UInt64.to_int Ctypes.uint64_t

let int_to_size_t =
  let open Unsigned in
  view ~write:Size_t.of_int ~read:Size_t.to_int Ctypes.size_t

let size_t_to_int =
  let open Unsigned in
  view ~write:Size_t.to_int ~read:Size_t.of_int Ctypes.int
