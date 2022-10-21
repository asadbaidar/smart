part of 'utils.dart';

class StackList<E> {
  final Queue<E> _underlyingQueue;

  StackList() : _underlyingQueue = Queue<E>();

  StackList.from(Iterable elements)
      : _underlyingQueue = Queue<E>.from(elements);

  int get length => _underlyingQueue.length;

  bool get isEmpty => _underlyingQueue.isEmpty;

  bool get isNotEmpty => _underlyingQueue.isNotEmpty;

  void clear() => _underlyingQueue.clear();

  E? peek() {
    if (isEmpty) return null;
    return _underlyingQueue.last;
  }

  E? pop() {
    if (isEmpty) return null;
    final E lastElement = _underlyingQueue.last;
    _underlyingQueue.removeLast();
    return lastElement;
  }

  E push(E element) {
    _underlyingQueue.addLast(element);
    return element;
  }
}