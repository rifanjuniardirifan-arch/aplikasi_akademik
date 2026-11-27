import 'package:flutter_test/flutter_test.dart';
import 'package:aplikasi_akademik/main.dart';

void main() {
  testWidgets('Dashboard menampilkan data awal mahasiswa', (tester) async {
    await tester.pumpWidget(const AplikasiAkademik());

    expect(find.text('Aplikasi Akademik'), findsOneWidget);
    expect(find.text('Rina Amelia'), findsOneWidget);
    expect(find.text('Budi Santoso'), findsOneWidget);
  });
}