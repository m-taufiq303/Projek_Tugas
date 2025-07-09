class Book {
  String title;
  String description;
  String imagePath;
  bool isBookmarked;

  Book({
    required this.title,
    required this.description,
    required this.imagePath,
    this.isBookmarked = false,
  });
}
