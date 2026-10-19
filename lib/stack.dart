/// A generic LIFO stack backed by a list. The top is the end of the list.
class Stack<T> {
  final List<T> _items = [];

  /// Adds [value] to the top of the stack.
  void push(T value) {
    _items.add(value);
  }

  /// Removes and returns the top value, or null when the stack is empty.
  T? pop() {
    if (_items.isEmpty) return null;
    return _items.removeLast();
  }

  /// Returns the top value without removing it, or null when empty.
  T? peek() {
    if (_items.isEmpty) return null;
    return _items.last;
  }

  /// Whether the stack holds no items.
  bool get isEmpty => _items.isEmpty;

  /// The number of items in the stack.
  int get size => _items.length;

  /// Removes all items.
  void clear() {
    _items.clear();
  }

  /// Returns a copy of the items, bottom first and top last.
  List<T> toList() => List<T>.of(_items);
}
