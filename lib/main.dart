// ignore_for_file: avoid_print

class Queue<T> {
  final List<T> _items = [];

  void enqueue(T item) {
    _items.add(item);
  }

  T? pop() {
    if (_items.isEmpty) {
      return null;
    }

    return _items.removeAt(0);
  }

  List<T> get items => List.unmodifiable(_items);
}

void main() {
  final antrian = Queue<int>();

  for (final nomor in [10, 20, 30]) {
    antrian.enqueue(nomor);
    print('$nomor berhasil ditambahkan ke antrian');
  }

  print('Isi antrian: ${antrian.items}');

  final nomorDilayani = antrian.pop();
  print('$nomorDilayani dihapus dari antrian');
  print('Isi antrian: ${antrian.items}');
}
