import 'package:get_storage/get_storage.dart';
import '../../domain/model/bookmark.dart';

class BookmarkLocalDatasource {
  final _box = GetStorage();
  final String _bookmarkKey = 'bookmarks';

  Future<List<Bookmark>> readBookmarks() async {
    try {
      final List<dynamic> jsonList = _box.read(_bookmarkKey);
      return jsonList.map((element) {
        return Bookmark(
          suratName: element["suratName"],
          noSurat: element["noSurat"],
          noAyat: element["noAyat"],
          catatan: element["catatan"],
          timeStamp: element["timeStamp"],
        );
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> writeBookmarks(List<Bookmark> bookmarks) async {
    try {
      await _box.write(
        _bookmarkKey,
        bookmarks
            .map(
              (e) => {
                'suratName': e.suratName,
                'noSurat': e.noSurat,
                'noAyat': e.noAyat,
                'catatan': e.catatan,
                'timeStamp': e.timeStamp,
              },
            )
            .toList(),
      );
    } catch (e) {
      print('gagal menulis ke storage: $e');
    }
  }
}
