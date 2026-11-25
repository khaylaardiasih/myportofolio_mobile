import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

// Pengelola state autentikasi dalam memori selama sesi aplikasi aktif
class AuthState extends ChangeNotifier {
  AuthState(this._apiClient, {String? initialToken}) : _token = initialToken;

  final ApiClient _apiClient;
  String? _token;

  // Getter token autentikasi saat ini
  String? get token => _token;

  // Status apakah pengguna saat ini sudah terautentikasi (login)
  bool get isLoggedIn => _token != null;

  // Fungsi login untuk menukar kredensial dengan token
  Future<void> login(String username, String password) async {
    _token = await _apiClient.obtainToken(username, password);
    notifyListeners();
  }

  // Fungsi logout untuk mencabut token di server dan mereset state lokal
  Future<void> logout() async {
    final current = _token;
    if (current == null) return;

    try {
      await _apiClient.logout(token: current);
    } on ApiException {
      // Abaikan error server saat logout agar state lokal tetap dibersihkan
    } finally {
      // Selalu hapus token dan beri tahu widget tree
      _token = null;
      notifyListeners();
    }
  }
}
