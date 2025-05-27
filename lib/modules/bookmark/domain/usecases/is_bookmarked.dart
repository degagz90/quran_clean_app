import '../repositories/bookmark_repository.dart';

class IsBookmarked {
  final BookmarkRepository repository;
  IsBookmarked(this.repository);

  Future<bool> execute(int noSurat, int noAyat) async {
    try {
      return await repository.isBookmarked(noSurat, noAyat);
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}
