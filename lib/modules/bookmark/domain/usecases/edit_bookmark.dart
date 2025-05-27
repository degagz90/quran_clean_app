import '../model/bookmark.dart';
import '../repositories/bookmark_repository.dart';

class EditBookmark {
  final BookmarkRepository repository;
  EditBookmark(this.repository);

  Future<void> execute(Bookmark bookmark) async {
    await repository.editBookmark(bookmark);
  }
}
