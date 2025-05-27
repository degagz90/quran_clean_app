import '../model/bookmark.dart';
import '../repositories/bookmark_repository.dart';

class AddBookmark {
  final BookmarkRepository repository;
  AddBookmark(this.repository);

  Future<void> execute(Bookmark bookmark) async {
    await repository.addBookmark(bookmark);
  }
}
