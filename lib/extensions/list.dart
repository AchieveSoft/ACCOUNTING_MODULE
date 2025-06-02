extension ListExtension on List {
  bool existsIndex(int index) => asMap().containsKey(index);
}
