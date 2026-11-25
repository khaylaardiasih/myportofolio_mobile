import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('Smoke test verifikasi inisialisasi aplikasi', (
    WidgetTester tester,
  ) async {
    // Membangun MyApp dengan injeksi ApiClient
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    // Memverifikasi teks judul aplikasi tampil di layar utama
    expect(find.text('MyPortfolio'), findsWidgets);
  });
}
