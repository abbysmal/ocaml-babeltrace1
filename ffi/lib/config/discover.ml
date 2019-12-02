open Printf

let minimum_rocks_version = "5.14"

module C = Configurator.V1

let () = C.main ~name:"libbabeltrace" begin fun c ->
let link_flags = ["-lbabeltrace"; "-Wl,--no-as-needed";"-lbabeltrace-ctf"] in

let known_paths = [
  "/usr/local/include/babeltrace";
  "/usr/include/babeltrace";
] in

let include_test = {|

#include <babeltrace.h>

int main() {
  return 0;
};

|}
in

let c_flag = List.find_opt (fun c_flag -> C.c_test c ~c_flags:["-I" ^ c_flag] ~link_flags include_test) known_paths in

match c_flag with
| None ->

   eprintf "failed to find an include path for babeltrace: are development headers installed on your system ?\n";
   eprintf "tested paths: %s\n" (String.concat " " known_paths);
   C.die "discover error"

| Some c_flag -> try

   C.Flags.write_sexp "c_flags.sexp"         ["-I" ^ c_flag];
   C.Flags.write_sexp "c_library_flags.sexp" link_flags;
   C.Flags.write_lines "c_flags.txt"         ["-I" ^ c_flag];
   C.Flags.write_lines "c_library_flags.txt" link_flags

  with Failure s -> C.die "failure: %s" s

end
