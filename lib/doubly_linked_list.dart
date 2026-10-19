import 'dart:core' as core;
import 'dart:core';

class DoublyLinkedListNode<T> {
  T value;
  DoublyLinkedListNode<T>? next;
  DoublyLinkedListNode<T>? prev;

  DoublyLinkedListNode(this.value);
}

class DoublyLinkedList<T> {
  DoublyLinkedListNode<T>? head;
  DoublyLinkedListNode<T>? tail;
  int _length = 0;

  int get length => _length;

  /// Appends [value] at the tail and returns the new node.
  DoublyLinkedListNode<T> push(T value) {
    final node = DoublyLinkedListNode<T>(value);
    final last = tail;
    if (last == null) {
      head = node;
    } else {
      last.next = node;
      node.prev = last;
    }
    tail = node;
    _length++;
    return node;
  }

  /// Removes and returns the tail node, or null if the list is empty.
  DoublyLinkedListNode<T>? pop() {
    final last = tail;
    if (last == null) return null;
    final newTail = last.prev;
    if (newTail == null) {
      head = null;
    } else {
      newTail.next = null;
    }
    tail = newTail;
    last.prev = null;
    _length--;
    return last;
  }

  /// Inserts [value] so it ends up at [index] (0..length). Returns the new
  /// node, or null if [index] is out of range.
  DoublyLinkedListNode<T>? insert(int index, T value) {
    if (index < 0 || index > _length) return null;
    if (index == _length) return push(value);
    final next = _nodeAt(index)!;
    final node = DoublyLinkedListNode<T>(value);
    final prev = next.prev;
    node.next = next;
    node.prev = prev;
    next.prev = node;
    if (prev == null) {
      head = node;
    } else {
      prev.next = node;
    }
    _length++;
    return node;
  }

  /// Removes and returns the node at [index], or null if out of range.
  DoublyLinkedListNode<T>? remove(int index) {
    final node = _nodeAt(index);
    if (node == null) return null;
    final prev = node.prev;
    final next = node.next;
    if (prev == null) {
      head = next;
    } else {
      prev.next = next;
    }
    if (next == null) {
      tail = prev;
    } else {
      next.prev = prev;
    }
    node.next = null;
    node.prev = null;
    _length--;
    return node;
  }

  /// Prints each value from head to tail, one per line.
  void print() {
    var node = head;
    while (node != null) {
      core.print(node.value);
      node = node.next;
    }
  }

  DoublyLinkedListNode<T>? _nodeAt(int index) {
    if (index < 0 || index >= _length) return null;
    DoublyLinkedListNode<T>? node;
    if (index < _length / 2) {
      node = head;
      for (var i = 0; i < index; i++) {
        node = node!.next;
      }
    } else {
      node = tail;
      for (var i = _length - 1; i > index; i--) {
        node = node!.prev;
      }
    }
    return node;
  }
}
