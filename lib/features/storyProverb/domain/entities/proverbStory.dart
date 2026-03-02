class ProverbStory {
  final String proverbStoryId;
  final String title;
  final String description;
  final String imageSrc;
  final String trackSrc;
  final Duration duration;
  final bool isFree;
  final bool? addedToFavorite;

  ProverbStory({
    required this.proverbStoryId,
    required this.title,
    required this.description,
    required this.imageSrc,
    required this.isFree,
    required this.trackSrc,
    required this.duration,
    this.addedToFavorite,
  });
}
