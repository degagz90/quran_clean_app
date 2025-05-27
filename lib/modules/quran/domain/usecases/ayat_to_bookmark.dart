import '../../../bookmark/domain/model/bookmark.dart';
import '../../../bookmark/domain/usecases/add_bookmark.dart';

class AyatToBookmark {
  final AddBookmark addBookmark;
  AyatToBookmark(this.addBookmark);

  Future<void> execute(
    String suratName,
    int noSurat,
    int noAyat,
    String catatan,
    String timeStamp,
  ) async {
    Bookmark bookmark = Bookmark(
      suratName: suratName,
      noSurat: noSurat,
      noAyat: noAyat,
      catatan: catatan,
      timeStamp: timeStamp,
    );
    await addBookmark.execute(bookmark);
  }
}
