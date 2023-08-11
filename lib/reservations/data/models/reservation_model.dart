
import 'package:isar/isar.dart';

part 'reservation_model.g.dart';

@collection
@Name("reservation_model")

class ReservationModel {
  ReservationModel({
      this.id, 
      this.event, 
      this.numberOfTickets, 
      this.guest, 
      this.status,});

  ReservationModel.fromJson(dynamic json) {
    id = json['id'];
    event = json['event'];
    numberOfTickets = json['number_of_tickets'];
    guest = json['guest'];
    status = json['status'];
  }

  Id localId = Isar.autoIncrement;
  int? id;
  int? event;
  int? numberOfTickets;
  int? guest;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['event'] = event;
    map['number_of_tickets'] = numberOfTickets;
    map['guest'] = guest;
    map['status'] = status;
    return map;
  }

}