import 'dart:async';

import 'package:get/get.dart';
import '../../data/repositories/sholat_repository_impl.dart';
import '../../domain/models/hijri_date.dart';
import '../../domain/models/location.dart';
import '../../domain/usecases/get_hijri_date.dart';
import '../../domain/usecases/get_location.dart';

class SholatController extends GetxController {
  final repository = SholatRepositoryImpl();
  Rx<DateTime> now = DateTime.now().obs;
  Rx<Location?> location = Rx<Location?>(null);
  Rx<HijriDate?> hijriDate = Rx<HijriDate?>(null);
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      now.value = DateTime.now();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> getLocation() async {
    final locationUseCase = GetLocation(repository);
    location.value = await locationUseCase.execute();
  }

  Future<void> getHijriDate() async {
    final hijriDateUseCase = GetHijriDate(repository);
    hijriDate.value = await hijriDateUseCase.execute(now.value);
  }
}
