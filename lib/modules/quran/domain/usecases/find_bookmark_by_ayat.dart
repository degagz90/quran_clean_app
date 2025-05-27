import '../../../bookmark/domain/model/bookmark.dart';
import '../../../bookmark/domain/usecases/find_bookmark.dart';

class FindBookmarkByAyat {
  final FindBookmark findBookmarkUseCase;
  FindBookmarkByAyat(this.findBookmarkUseCase);

  Future<Bookmark> execute(int noSurat, int noAyat) async {
    return await findBookmarkUseCase.execute(noSurat, noAyat);
  }
}
