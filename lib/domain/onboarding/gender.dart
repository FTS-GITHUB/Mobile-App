class Gender {
  int? index;
  String? value;

  Gender({
    this.index,
    this.value,
  });

  Gender copyWith({
    int? index,
    String? value,
  }) =>
      Gender(
        index: index ?? this.index,
        value: value ?? this.value,
      );
}
