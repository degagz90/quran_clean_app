import '../models/location.dart';
import '../repositories/sholat_repository.dart';

class GetQibla {
  final SholatRepository repository;
  GetQibla(this.repository);

  Future<double> execute(Location location) async {
    return await repository.getQiblaDirectrion(location);
  }
}
