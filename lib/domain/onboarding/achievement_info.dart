class AchievementInfo {
  final int? index;
  final String? title;

  AchievementInfo({
    this.index,
    this.title,
  });

  AchievementInfo copyWith({
    int? index,
    String? title,
  }) =>
      AchievementInfo(
        index: index ?? this.index,
        title: title ?? this.title,
      );
}
