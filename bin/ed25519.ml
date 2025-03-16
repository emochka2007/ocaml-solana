open Digestif

let random_string n = Mirage_crypto_rng.generate n
let random_bytes s = Bytes.of_string s

(* module Keypair = struct *)
(*    let secret_key_len = 32 *)
(*    let secret = "" *)
(*    let public = "" *)
(* end *)

(* Init rng *)
let rng_init = Mirage_crypto_rng_unix.use_default ()

let generate_secret =
  let () = rng_init in
  random_bytes (random_string 32)

(* let hex_rng = Hex.of_bytes bytes in *)
(* print_endline (Hex.show hex_rng) *)
let hash_bytes digest =
  let raw_bytes = SHA512.to_raw_string digest in
  Bytes.of_string raw_bytes

let sha512_bytes bytes = SHA512.digest_bytes bytes

let derive_pub_key_from_secret secret =
  let hash = sha512_bytes secret in
  (*  print_endline ("sha512 " ^ SHA512.to_hex hash); *)
  print_endline ("sha512 " ^ Bytes.to_string (hash_bytes hash));
  let digest = Bytes.create 32 in
  Bytes.blit (hash_bytes hash) 0 digest 0 32;
  print_endline ("digest " ^ Bytes.to_string digest);
  hash
(* let hash *)
(* let digest = *)
(* Skip clamping *)
(* https://www.jcraige.com/an-explainer-on-ed25519-clamping *)
(* let clamp_secret = *)

(* module SecretKey = struct *)
(* end *)
(*  *)
(* module PublicKey = struct *)
(* (*    n "Edwards y" / "Ed25519" format, the curve point \((x,y)\) *)
(*      is determined by the \(y\)-coordinate and the sign of \(x\). *) *)
(* (*    The first 255 bits of a CompressedEdwardsY represent the \(y\)-coordinate. *)
(*      The high bit of the 32nd byte gives the sign of \(x\). *) *)
(*      let compressed_edwards_y = "" *)
(*      let edwards_point = "" *)
(* end *)
(*  *)
(* (* An EdwardsPoint represents a point on the Edwards form of Curve25519. *) *)
(* module EdwardsPoint = struct *)
(* (*    x = [FieldElement51; 5] *) *)
(*    let x = (0, 0, 0, 0, 0) *)
(*    let y = (0, 0, 0, 0, 0) *)
(*    let z = (0, 0, 0, 0, 0) *)
(*    let t = (0, 0, 0, 0, 0) *)
(* end *)
(*  *)
(* (* A FieldElement51 represents an element of the field \( \mathbb Z / (2^{255} - 19)\). *) *)
(* (* In the 64-bit implementation, a FieldElement is represented in radix \(2^{51}\) as five u64s; *)
(* the coefficients are allowed to grow up to \(2^{54}\) between reductions modulo \(p\). *) *)
(* module FieldElement51 = struct *)
(*  *)
(* end *)
