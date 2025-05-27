import '../model/bookmark.dart';
import '../repositories/bookmark_repository.dart';

class FindBookmark {
  final BookmarkRepository repository;
  FindBookmark(this.repository);

  Future<Bookmark> execute(int noSurat, int noAyat) async {
    return await repository.findBookmark(noSurat, noAyat);
  }
}
