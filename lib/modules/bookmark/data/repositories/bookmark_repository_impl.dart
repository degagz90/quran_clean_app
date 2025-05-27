import '../../domain/model/bookmark.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../datasources/bookmark_local_datasource.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final _lokalData = BookmarkLocalDatasource();

  @override
  Future<void> addBookmark(Bookmark bookmark) async {
    List<Bookmark> bookmarks = await _lokalData.readBookmarks();
    bookmarks.add(bookmark);
    await _lokalData.writeBookmarks(bookmarks);
  }

  @override
  Future<void> deleteBookmark(Bookmark bookmark) async {
    List<Bookmark> bookmarks = await _lokalData.readBookmarks();
    bookmarks.removeWhere(
      (element) =>
          element.noSurat == bookmark.noSurat &&
          element.noAyat == bookmark.noAyat,
    );
    await _lokalData.writeBookmarks(bookmarks);
  }

  @override
  Future<void> editBookmark(Bookmark bookmark) async {
    List<Bookmark> bookmarks = await _lokalData.readBookmarks();
    final index = bookmarks.indexWhere(
      (element) =>
          element.noSurat == bookmark.noSurat &&
          element.noAyat == bookmark.noAyat,
    );
    bookmarks[index] = bookmark;
    await _lokalData.writeBookmarks(bookmarks);
  }

  @override
  Future<List<Bookmark>> getBookmarks() async {
    List<Bookmark> bookmarks = await _lokalData.readBookmarks();
    return bookmarks;
  }

  @override
  Future<bool> isBookmarked(int noSurat, int noAyat) async {
    List<Bookmark> bookmarks = await _lokalData.readBookmarks();
    return bookmarks.any(
      (element) => element.noSurat == noSurat && element.noAyat == noAyat,
    );
  }

  @override
  Future<Bookmark> findBookmark(int noSurat, int noAyat) async {
    List<Bookmark> bookmarks = await _lokalData.readBookmarks();
    Bookmark bookmark = bookmarks.firstWhere((element) {
      return element.noSurat == noSurat && element.noAyat == noAyat;
    });
    return bookmark;
  }
}
