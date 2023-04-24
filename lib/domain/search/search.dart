import 'dart:ui';

class Search {
  final String? imageUrl;
  final String? title;
  final String? artistName;
  final bool? isFavorite;
  final VoidCallback? onFavoritePressed;

  Search({
    this.imageUrl,
    this.title,
    this.artistName,
    this.isFavorite=false,
    this.onFavoritePressed,
});
}
