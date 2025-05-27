import '../model/bookmark.dart';

abstract class BookmarkRepository {
  Future<void> addBookmark(Bookmark bookmark);
  Future<void> deleteBookmark(Bookmark bookmark);
  Future<void> editBookmark(Bookmark bookmark);
  Future<List<Bookmark>> getBookmarks();
  Future<bool> isBookmarked(int noSurat, int noAyat);
  Future<Bookmark> findBookmark(int noSurat, int noAyat);
}
