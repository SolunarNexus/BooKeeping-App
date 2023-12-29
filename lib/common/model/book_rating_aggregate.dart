class BookRatingAggregate {
  final String bookId;
  final String title;
  final double ratingAverage;
  final int ratingCount;

  BookRatingAggregate(
      {required this.bookId,
      required this.title,
      required this.ratingAverage,
      required this.ratingCount});
}
