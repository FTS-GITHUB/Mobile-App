class Age {
  int? index;
  String? value;

  Age({
    this.index,
    this.value,
  });

  Age copyWith({
    int? index,
    String? value,
  }) =>
      Age(
        index: index ?? this.index,
        value: value ?? this.value,
      );
}
