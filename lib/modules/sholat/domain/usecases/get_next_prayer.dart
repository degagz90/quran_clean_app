import 'package:quran_clean/modules/sholat/domain/models/location.dart';
import 'package:quran_clean/modules/sholat/domain/models/next_sholat.dart';
import 'package:quran_clean/modules/sholat/domain/repositories/sholat_repository.dart';

class GetNextPrayer {
  final SholatRepository repository;
  GetNextPrayer(this.repository);

  Future<NextSholat> execute(Location location) async {
    return await repository.getNextPrayer(location);
  }
}
