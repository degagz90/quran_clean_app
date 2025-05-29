import 'package:quran_clean/modules/sholat/domain/models/hijri_date.dart';
import 'package:quran_clean/modules/sholat/domain/repositories/sholat_repository.dart';

class GetHijriDate {
  final SholatRepository repository;
  GetHijriDate(this.repository);

  Future<HijriDate> execute(DateTime dateTime) async {
    return await repository.getHijriyahDate(dateTime);
  }
}
