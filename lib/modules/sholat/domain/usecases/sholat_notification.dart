import '../../../notification/domain/usecases/show_notification.dart';

class SholatNotification {
  final ShowNotification showNotification;
  SholatNotification(this.showNotification);

  Future<void> execute(String sholat) async {
    await showNotification.execute(sholat);
  }
}
