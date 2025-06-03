import '../../../notification/domain/usecases/cancel_all_notifications.dart';

class DeleteAdzanNotif {
  final CancelAllNotifications cancelAllNotificationsUseCase;
  DeleteAdzanNotif(this.cancelAllNotificationsUseCase);

  Future<void> execute() async {
    await cancelAllNotificationsUseCase.execute();
  }
}
