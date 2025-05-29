import '../models/location.dart';
import '../repositories/sholat_repository.dart';

class GetLocation {
  final SholatRepository repository;
  GetLocation(this.repository);

  Future<Location> execute() async {
    return await repository.getLocation();
  }
}
