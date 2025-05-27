import '../model/bookmark.dart';
import '../repositories/bookmark_repository.dart';

class GetBookmarks {
  final BookmarkRepository repository;
  GetBookmarks(this.repository);

  Future<List<Bookmark>> execute() async {
    return await repository.getBookmarks();
  }
}
