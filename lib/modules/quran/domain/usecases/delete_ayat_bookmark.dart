import 'package:quran_clean/modules/bookmark/domain/model/bookmark.dart';
import 'package:quran_clean/modules/bookmark/domain/usecases/delete_bookmark.dart';

class DeleteAyatBookmark {
  final DeleteBookmark deleteBookmarkUseCase;
  DeleteAyatBookmark(this.deleteBookmarkUseCase);

  Future<void> execute(Bookmark bookmark) async {
    await deleteBookmarkUseCase.execute(bookmark);
  }
}
