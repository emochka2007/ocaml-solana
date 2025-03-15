open Rpc

(*Wallet sdk
 - Address generation
 - Sign and submit transaction
 *)
module Client = RpcClient (Sender)

let () = Lwt_main.run (Client.get_block ~block_number:430)
(*  Rpc.RpcClient.send_message (); *)
(*  let sender = Rpc.HttpSender.create ~url:"sol_url" ~request_id:0 in *)
(*  let rpc = Rpc.RpcClient.create sender in *)

