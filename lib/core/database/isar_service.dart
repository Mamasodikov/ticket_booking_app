import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';

class IsarService {
  late final Isar isar;

  IsarService._create(this.isar);

  static Future<IsarService> buildIsarService() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [EventModelSchema, ReservationModelSchema],
      directory: dir.path,
    );

    // print('Isar opened');
    return IsarService._create(isar);
  }
}
