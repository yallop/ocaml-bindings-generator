open Cmdliner

let export =
  let doc = "Regular expression for exportable definitions." in
  Arg.(value & opt string ".*" & info ["export"] ~docv:"EXPORT" ~doc)

let types_file =
  let doc = "Filename for the types bindings." in
  Arg.(value & opt (some string) None & info ["types-filename"] ~docv:"FILENAME" ~doc)

let functions_file =
  let doc = "Filename for the function bindings." in
  Arg.(value & opt (some string) None & info ["functions-filename"] ~docv:"FILENAME" ~doc)

let input =
  let doc = "Input file (should be preprocessed with cc -E)." in
  Arg.(value & pos 0 string "/dev/stdin" & info [] ~docv:"input" ~doc)

let term =
  Term.(pure Extract_types.main $ export $ input $ types_file $ functions_file)

let info =
  Term.info "ocaml-bindings-generator" ~version:"0.0.1" ~doc:"" ~man:[]

let () = match Term.eval (term, info) with `Error _ -> exit 1 | _ -> exit 0
