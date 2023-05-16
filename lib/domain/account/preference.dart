class Preference {
  final bool? downloadWifi;
  final String? audioQuality;

  Preference({
    this.downloadWifi,
    this.audioQuality,
  });

  Preference copyWith({
    bool? downloadWifi,
    String? audioQuality,
    bool? autoDownloadAudio,
  }) =>
      Preference(
        downloadWifi: downloadWifi ?? this.downloadWifi,
        audioQuality: audioQuality ?? this.audioQuality,
      );
}
