import 'dart:async';

import 'package:dart_dsa/doubly_linked_list.dart';
import 'package:test/test.dart';

DoublyLinkedList<int> build(List<int> values) {
  final list = DoublyLinkedList<int>();
  for (final v in values) {
    list.push(v);
  }
  return list;
}

List<int> forward(DoublyLinkedList<int> list) {
  final out = <int>[];
  for (var n = list.head; n != null; n = n.next) {
    out.add(n.value);
  }
  return out;
}

List<int> backward(DoublyLinkedList<int> list) {
  final out = <int>[];
  for (var n = list.tail; n != null; n = n.prev) {
    out.add(n.value);
  }
  return out.reversed.toList();
}

void expectList(DoublyLinkedList<int> list, List<int> expected) {
  expect(forward(list), expected);
  expect(backward(list), expected);
  expect(list.length, expected.length);
  expect(list.head?.prev, isNull);
  expect(list.tail?.next, isNull);
  if (expected.isEmpty) {
    expect(list.head, isNull);
    expect(list.tail, isNull);
  }
}

List<String> capturePrint(void Function() body) {
  final lines = <String>[];
  runZoned(
    body,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) => lines.add(line),
    ),
  );
  return lines;
}

void main() {
  group('push', () {
    test('onto empty list', () {
      final list = DoublyLinkedList<int>();
      final node = list.push(1);
      expect(node.value, 1);
      expect(list.head, same(node));
      expect(list.tail, same(node));
      expectList(list, [1]);
    });

    test('appends and links', () {
      final list = build([0, 2, 3]);
      expectList(list, [0, 2, 3]);
    });
  });

  group('pop', () {
    test('empty returns null', () {
      final list = DoublyLinkedList<int>();
      expect(list.pop(), isNull);
      expectList(list, []);
    });

    test('single element', () {
      final list = build([1]);
      expect(list.pop()!.value, 1);
      expectList(list, []);
    });

    test('multiple elements clears links', () {
      final list = build([1, 2, 3]);
      final node = list.pop()!;
      expect(node.value, 3);
      expect(node.prev, isNull);
      expect(node.next, isNull);
      expectList(list, [1, 2]);
    });
  });

  group('insert', () {
    test('into empty list at 0', () {
      final list = DoublyLinkedList<int>();
      expect(list.insert(0, 5)!.value, 5);
      expectList(list, [5]);
    });

    test('at head', () {
      final list = build([2, 3]);
      final node = list.insert(0, 1)!;
      expect(list.head, same(node));
      expectList(list, [1, 2, 3]);
    });

    test('at tail (index == length)', () {
      final list = build([1, 2]);
      final node = list.insert(2, 3)!;
      expect(list.tail, same(node));
      expectList(list, [1, 2, 3]);
    });

    test('in the middle', () {
      final list = build([1, 2, 4, 5]);
      final node = list.insert(2, 3)!;
      expect(node.prev!.value, 2);
      expect(node.next!.value, 4);
      expectList(list, [1, 2, 3, 4, 5]);
    });

    test('out of range returns null and leaves list unchanged', () {
      final list = build([1, 2]);
      expect(list.insert(-1, 9), isNull);
      expect(list.insert(3, 9), isNull);
      expectList(list, [1, 2]);
    });

    test('zero value is stored', () {
      final list = DoublyLinkedList<int>();
      list.insert(0, 0);
      expectList(list, [0]);
    });
  });

  group('remove', () {
    test('empty list returns null', () {
      final list = DoublyLinkedList<int>();
      expect(list.remove(0), isNull);
      expectList(list, []);
    });

    test('single element', () {
      final list = build([1]);
      expect(list.remove(0)!.value, 1);
      expectList(list, []);
    });

    test('head', () {
      final list = build([1, 2, 3]);
      final node = list.remove(0)!;
      expect(node.value, 1);
      expect(node.next, isNull);
      expect(node.prev, isNull);
      expectList(list, [2, 3]);
    });

    test('tail', () {
      final list = build([1, 2, 3]);
      expect(list.remove(2)!.value, 3);
      expectList(list, [1, 2]);
    });

    test('middle', () {
      final list = build([1, 2, 3, 4, 5]);
      final node = list.remove(2)!;
      expect(node.value, 3);
      expect(node.next, isNull);
      expect(node.prev, isNull);
      expectList(list, [1, 2, 4, 5]);
    });

    test('out of range returns null and leaves list unchanged', () {
      final list = build([1, 2, 3]);
      expect(list.remove(-1), isNull);
      expect(list.remove(3), isNull);
      expect(list.remove(10), isNull);
      expectList(list, [1, 2, 3]);
    });
  });

  group('length', () {
    test('tracks operations', () {
      final list = DoublyLinkedList<int>();
      expect(list.length, 0);
      list.push(1);
      list.push(3);
      list.insert(1, 2);
      expect(list.length, 3);
      list.remove(0);
      list.pop();
      expect(list.length, 1);
      list.pop();
      list.pop();
      expect(list.length, 0);
    });
  });

  group('print', () {
    test('empty prints nothing', () {
      expect(capturePrint(DoublyLinkedList<int>().print), isEmpty);
    });

    test('prints head to tail, one per line', () {
      final list = build([1, 2, 3]);
      expect(capturePrint(list.print), ['1', '2', '3']);
    });
  });
}
