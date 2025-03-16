open Rpc
open Ed25519

(*Wallet sdk
 - Address generation
 - Sign and submit transaction
 *)
module Client = RpcClient (Sender)

let () =
  let secret = generate_secret in
  ignore (derive_pub_key_from_secret secret)
;;

(* derive_pub_key_from_secret *)
Lwt_main.run (Client.get_block ~block_number:430)

(*  Rpc.RpcClient.send_message (); *)
(*  let sender = Rpc.HttpSender.create ~url:"sol_url" ~request_id:0 in *)
(*  let rpc = Rpc.RpcClient.create sender in *)
