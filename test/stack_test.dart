import 'package:dart_dsa/stack.dart';
import 'package:test/test.dart';

void main() {
  group('Stack', () {
    test('new stack is empty', () {
      final s = Stack<int>();
      expect(s.isEmpty, isTrue);
      expect(s.size, 0);
      expect(s.toList(), isEmpty);
    });

    test('pop, peek and clear on empty stack', () {
      final s = Stack<int>();
      expect(s.pop(), isNull);
      expect(s.peek(), isNull);
      s.clear();
      expect(s.isEmpty, isTrue);
      expect(s.size, 0);
    });

    test('push updates size and isEmpty', () {
      final s = Stack<int>();
      s.push(1);
      expect(s.isEmpty, isFalse);
      expect(s.size, 1);
      s.push(2);
      expect(s.size, 2);
    });

    test('pops in LIFO order', () {
      final s = Stack<int>()
        ..push(1)
        ..push(2)
        ..push(3);
      expect(s.pop(), 3);
      expect(s.pop(), 2);
      expect(s.pop(), 1);
      expect(s.pop(), isNull);
    });

    test('isEmpty and size after pop to empty', () {
      final s = Stack<int>()..push(1);
      s.pop();
      expect(s.isEmpty, isTrue);
      expect(s.size, 0);
    });

    test('peek does not remove', () {
      final s = Stack<int>()
        ..push(1)
        ..push(2);
      expect(s.peek(), 2);
      expect(s.peek(), 2);
      expect(s.size, 2);
    });

    test('clear empties the stack and allows reuse', () {
      final s = Stack<int>()
        ..push(1)
        ..push(2);
      s.clear();
      expect(s.isEmpty, isTrue);
      expect(s.size, 0);
      expect(s.pop(), isNull);
      s.push(5);
      expect(s.peek(), 5);
      expect(s.size, 1);
    });

    test('toList is bottom first', () {
      final s = Stack<int>()
        ..push(1)
        ..push(2)
        ..push(3);
      expect(s.toList(), [1, 2, 3]);
    });

    test('mutating toList does not affect the stack', () {
      final s = Stack<int>()
        ..push(1)
        ..push(2);
      final list = s.toList();
      list.add(9);
      list.removeAt(0);
      expect(s.toList(), [1, 2]);
      expect(s.size, 2);
    });

    test('falsy values work', () {
      final z = Stack<int>()..push(0);
      expect(z.peek(), 0);
      expect(z.pop(), 0);
      expect(z.isEmpty, isTrue);
      final e = Stack<String>()..push('');
      expect(e.peek(), '');
      expect(e.pop(), '');
      expect(e.isEmpty, isTrue);
    });

    test('holds null values in Stack<int?>', () {
      final s = Stack<int?>()
        ..push(null)
        ..push(1);
      expect(s.pop(), 1);
      expect(s.size, 1);
      expect(s.isEmpty, isFalse);
      expect(s.pop(), isNull);
      expect(s.isEmpty, isTrue);
    });
  });
}
