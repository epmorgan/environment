open Unix

(* Function to get today's date as a string in YYYY-MM-DD format *)
let get_todays_date () =
  let tm = localtime (time ()) in
  Printf.sprintf "%04d-%02d-%02d" (tm.tm_year + 1900) (tm.tm_mon + 1) tm.tm_mday

(* Function to change directory *)
let change_directory dir =
  Sys.chdir dir

(* Function to create a folder if it doesn't exist *)
let create_folder_if_not_exists folder_name =
  if not (Sys.file_exists folder_name) then Unix.mkdir folder_name 0o755

(* Function to create a markdown file with the given name inside the folder *)
let create_markdown_file folder_name file_name =
  let file_path = folder_name ^ "/" ^ file_name ^ ".md" in
  if not (Sys.file_exists file_path) then
    let oc = open_out file_path in
    close_out oc
  else
    ();
  file_path

(* Function to open the markdown file in neovim *)
let open_in_neovim file_path =
  let command = Printf.sprintf "nvim %s" file_path in
  ignore (Sys.command command)

(* Main function *)
let () =
  let notes_dir = Sys.getenv "HOME" ^ "/notes" in
  let date_folder = get_todays_date () in

  (* Check if file name was passed as argument *)
  if Array.length Sys.argv < 2 then
    Printf.printf "Usage: %s <file-name>\n" Sys.argv.(0)
  else
    let file_name = Sys.argv.(1) in

    (* Step 1: Change directory to ~/notes *)
    change_directory notes_dir;

    (* Step 2: Create folder for today if it doesn't exist *)
    create_folder_if_not_exists date_folder;

    (* Step 3: Create markdown file with the provided name *)
    let file_path = create_markdown_file date_folder file_name in

    (* Step 4: Open the file in neovim *)
    open_in_neovim file_path

