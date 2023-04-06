class UserLevelInfo {
  final int? index;
  final String? title;

  UserLevelInfo({
    this.index,
    this.title,
  });

  UserLevelInfo copyWith({
    int? index,
    String? title,
  }) =>
      UserLevelInfo(
        title: title ?? this.title,
        index: index ?? this.index,
      );
}
