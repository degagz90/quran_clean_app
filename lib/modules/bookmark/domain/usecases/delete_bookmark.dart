import '../model/bookmark.dart';
import '../repositories/bookmark_repository.dart';

class DeleteBookmark {
  final BookmarkRepository repository;
  DeleteBookmark(this.repository);

  Future<void> execute(Bookmark bookmark) async {
    await repository.deleteBookmark(bookmark);
  }
}
