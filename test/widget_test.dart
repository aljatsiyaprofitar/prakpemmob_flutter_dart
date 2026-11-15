import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dart/main.dart';
import 'package:flutter_dart/ui/produk_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Test UI navigasi Registrasi & Login', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Login'), findsWidgets);
    expect(find.text('Registrasi'), findsOneWidget);

    // Tap link registrasi
    await tester.tap(find.text('Registrasi'));
    await tester.pumpAndSettle();
    expect(find.text('Nama'), findsOneWidget);
    expect(find.text('Konfirmasi Password'), findsOneWidget);
  });

  testWidgets('Test UI ProdukPage, Detail, Form', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProdukPage()));
    expect(find.text('List Produk'), findsOneWidget);
    expect(find.text('Kamera'), findsOneWidget);
    expect(find.text('Kulkas'), findsOneWidget);

    // Tap salah satu item untuk buka detail
    await tester.tap(find.text('Kamera'));
    await tester.pumpAndSettle();
    expect(find.text('Detail Produk'), findsOneWidget);
    expect(find.text('EDIT'), findsOneWidget);
    expect(find.text('DELETE'), findsOneWidget);

    // Tap EDIT untuk buka Ubah Produk
    await tester.tap(find.text('EDIT'));
    await tester.pumpAndSettle();
    expect(find.text('UBAH PRODUK'), findsOneWidget);
    expect(find.text('UBAH'), findsOneWidget);
  });

  testWidgets(
    'Registrasi menyimpan akun dan akun dapat digunakan untuk login',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Registrasi'));
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Budi');
      await tester.enterText(fields.at(1), 'budi@example.com');
      await tester.enterText(fields.at(2), 'rahasia123');
      await tester.enterText(fields.at(3), 'rahasia123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Registrasi'));
      await tester.pumpAndSettle();

      expect(find.text('Registrasi berhasil'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'budi@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'rahasia123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('List Produk'), findsOneWidget);
    },
  );

  testWidgets('Login salah menampilkan peringatan', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'salah@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'salah123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Username dan Password Salah'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
  });
}
