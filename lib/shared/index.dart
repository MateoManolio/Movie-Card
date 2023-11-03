class Index {
  int index;

  Index({required this.index});

  int get getIndex => index;

  void setIndex(int newIndex) => index = newIndex;

  factory Index.initialIndex() => Index(index: 0);
}
