import 'package:get/get.dart';
import 'package:quran_clean/modules/bookmark/domain/usecases/delete_bookmark.dart';

import '../../data/repositories/bookmark_repository_impl.dart';
import '../../domain/model/bookmark.dart';
import '../../domain/usecases/get_bookmarks.dart';

class BookmarkController extends GetxController {
  final bookmarkRepository = BookmarkRepositoryImpl();
  RxList<Bookmark> bookmarks = <Bookmark>[].obs;

  @override
  void onInit() {
    getBookmarks();
    super.onInit();
  }

  Future<void> getBookmarks() async {
    final useCase = GetBookmarks(bookmarkRepository);
    bookmarks.value = await useCase.execute();
  }

  Future<void> deleteBookmark(Bookmark bookmark) async {
    final useCase = DeleteBookmark(bookmarkRepository);
    await useCase.execute(bookmark);
    await getBookmarks();
  }
}
