import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:go_tashkent_client/const/app_config.dart';

class PayloadHelper {
  final String masterSecret;

  PayloadHelper({String? master}) : masterSecret = master ?? AppConfig.MASTER_SECRET;

  // base64url encode without padding
  String _b64u(Uint8List bytes) => base64UrlEncode(bytes).replaceAll('=', '');

  // // base64url decode (handles missing padding)
  // Uint8List _b64uDecode(String s) {
  //   var out = s.replaceAll('-', '+').replaceAll('_', '/');
  //   while (out.length % 4 != 0) out += '=';
  //   return base64Decode(out);
  // }

  // secure random nonce generator (default 16 bytes)
  Uint8List _randomBytes(int length) {
    final rnd = Random.secure();
    return Uint8List.fromList(List<int>.generate(length, (_) => rnd.nextInt(256)));
  }

  // derive key: HMAC-SHA256(masterSecret, nonceRaw)
  Uint8List _deriveKey(Uint8List nonceRaw) {
    final hmac = Hmac(sha256, utf8.encode(masterSecret));
    final digest = hmac.convert(nonceRaw);
    return Uint8List.fromList(digest.bytes); // 32 bytes
  }

  // compute HMAC-SHA256 over iv + ts (cipher olib tashlandi!)
  Uint8List _computeMac(Uint8List derivedKey, Uint8List iv, String ts) {
    final hmac = Hmac(sha256, derivedKey);
    final tsBytes = utf8.encode(ts);
    final msg = Uint8List.fromList([...iv, ...tsBytes]);
    final digest = hmac.convert(msg);
    return Uint8List.fromList(digest.bytes);
  }

  /// Public: creates payload map with keys:
  /// { nonce, iv, ts, mac } (cipher yo‘q, ts = seconds)
  Map<String, String> createPayload() {
    final nonce = _randomBytes(16);
    final nonceB64u = _b64u(nonce);

    final derived = _deriveKey(nonce);

    final iv = _randomBytes(16); // faqat random IV ishlatiladi

    final ts = (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000).toString();
    final mac = _computeMac(derived, iv, ts);

    return {
      'nonce': nonceB64u,
      'iv': _b64u(iv),
      'ts': ts,
      'mac': _b64u(mac),
    };
  }

  /// Convenience: returns JSON string ready to send
  String createPayloadJson() => jsonEncode(createPayload());
}
