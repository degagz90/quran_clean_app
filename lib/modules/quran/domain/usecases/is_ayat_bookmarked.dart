import 'package:quran_clean/modules/bookmark/domain/usecases/is_bookmarked.dart';

class IsAyatBookmarked {
  final IsBookmarked isBookmarkedUseCase;
  IsAyatBookmarked(this.isBookmarkedUseCase);

  Future<bool> execute(int noSurat, int noAyat) async {
    return await isBookmarkedUseCase.execute(noSurat, noAyat);
  }
}
