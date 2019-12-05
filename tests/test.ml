type error = [ `Msg of string ]
let pp_error ppf = function `Msg x -> Fmt.string ppf x
let error = Alcotest.testable pp_error (=)
let t = Alcotest.(result unit error)

let check (name, fn) = name, `Quick, (fun () -> Alcotest.check t name (Ok ()) (fn ()))

let test_context = List.map check Test_context.tests

let () =
  Junit_alcotest.run_and_report "Babeltrace" [
    "test_context", test_context;
  ]
  |> fun (r, _) ->
  Junit.(to_file (make [r]) "alcotest-junit.xml")
