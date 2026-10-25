// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_dart/main.dart';

void main() {
  test('Queue menggunakan prinsip FIFO', () {
    final antrian = Queue<int>();

    antrian.enqueue(10);
    antrian.enqueue(20);
    antrian.enqueue(30);

    expect(antrian.pop(), 10);
    expect(antrian.items, [20, 30]);
  });

  test('Queue kosong mengembalikan null saat pop', () {
    expect(Queue<int>().pop(), isNull);
  });
}
