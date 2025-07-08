class Book {
  final String title;
  final String imagePath;
  final String description;
  bool isBookmarked;

  Book({
    required this.title,
    required this.imagePath,
    required this.description,
    this.isBookmarked = false,
  });
}
