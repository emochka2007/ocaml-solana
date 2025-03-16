(* Client *)
(* rpc-client/src/nonblocking/rpc_client.rs *)
(* //! Communication with a Solana node over RPC asynchronously . *)
(* - JsonRpcClient *)
type commitment_level = Processed | Confirmed | Finalized
type http_sender = { url : string; request_id : int }
type rpc_client = { sender : http_sender }

type json_rpc_request = {
  jsonrpc : string;
  rpc_method : string;
  id : string; (*    params: 'a *)
}

type client_request = { body : string }

module type HttpSender = sig
  val create : url:string -> request_id:int -> http_sender
  val send : request:client_request -> string Lwt.t
end

module Sender = struct
  open Lwt
  open Cohttp_lwt_unix

  let uri = ""
  let create ~url ~request_id = { url; request_id }

  let send ~request =
    let body = request.body in
    let headers = Cohttp.Header.init_with "Content-Type" "application/json" in
    Client.post ~headers
      ~body:(Cohttp_lwt.Body.of_string body)
      (Uri.of_string uri)
    >>= fun (_resp, res_body) -> Cohttp_lwt.Body.to_string res_body
end

module RpcClient =
functor
  (Sender : HttpSender)
  ->
  struct
    open Lwt

    let message = "rpc call"

    let request : json_rpc_request =
      { jsonrpc = "2.0"; rpc_method = "get"; id = "id-xx" }

    let commitment = Processed
    let send_message () = print_endline message

    let build_get_block_json ~block_number =
      let json_string =
        `Assoc
          [
            ("jsonrpc", `String "2.0");
            ("id", `Int 0);
            ("method", `String "getBlock");
            ( "params",
              `List
                [
                  `Int block_number;
                  `Assoc
                    [
                      ("encoding", `String "json");
                      ("maxSupportedTransactionVersion", `Int 0);
                      ("transactionDetails", `String "full");
                      ("rewards", `Bool false);
                    ];
                ] );
          ]
      in
      let body = Yojson.Safe.to_string json_string in
      body

    let get_block ~block_number =
      let build_request = build_get_block_json ~block_number in
      let request = { body = build_request } in
      Sender.send ~request >>= fun value ->
      print_endline value;
      Lwt.return ()

    let create ~url ~request_id = { url; request_id }
  end
