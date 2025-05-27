import '../../../bookmark/domain/model/bookmark.dart';
import '../../../bookmark/domain/usecases/edit_bookmark.dart';

class EditAyatBookmark {
  final EditBookmark editBookmarkUseCase;
  EditAyatBookmark(this.editBookmarkUseCase);

  Future<void> execute(Bookmark bookmark) async {
    await editBookmarkUseCase.execute(bookmark);
  }
}
