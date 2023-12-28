enum CollectionType {
  book(collectionPath: "book"),
  user(collectionPath: "user"),
  myBook(collectionPath: "my_book"),
  bookRating(collectionPath: "book_rating"),
  friend(collectionPath: "friend"),
  friendRequest(collectionPath: "friend_request"),
  recommendation(collectionPath: "recommendation");

  final String collectionPath;

  const CollectionType({required this.collectionPath});
}
