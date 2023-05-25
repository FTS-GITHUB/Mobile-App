import 'dart:ui';

class Search {
  final String? imageUrl;
  final String? title;
  final String? artistName;
  final bool? isFavorite;
  final VoidCallback? onItemTapped;
  final bool isDownloadPage;

  Search({
    this.imageUrl,
    this.title,
    this.artistName,
    this.isFavorite=false,
    this.onItemTapped,
    this.isDownloadPage = false,
});
}
