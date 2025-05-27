import '../repositories/bookmark_repository.dart';

class IsBookmarked {
  final BookmarkRepository repository;
  IsBookmarked(this.repository);

  Future<bool> execute(int noSurat, int noAyat) async {
    return await repository.isBookmarked(noSurat, noAyat);
  }
}
