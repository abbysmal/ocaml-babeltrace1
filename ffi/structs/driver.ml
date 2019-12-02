let prologue = "
#include <babeltrace.h>
#include <ctf/events.h>
"

let () =
  print_endline prologue;
  Cstubs_structs.write_c Format.std_formatter (module Babeltrace1_types.Struct_stubs)
