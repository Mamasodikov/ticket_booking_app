
import 'package:isar/isar.dart';

part 'event_model.g.dart';

@collection
@Name("murojat_model")
class EventModel {
  EventModel({
      this.id, 
      this.name, 
      this.topic, 
      this.date, 
      this.place, 
      this.numberOfSeats, 
      this.ticketPrice, 
      this.currency, 
      this.host, 
      this.guests, 
      this.thumbnail, 
      this.description,});

  EventModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    topic = json['topic'];
    date = json['date'];
    place = json['place'];
    numberOfSeats = json['number_of_seats'];
    ticketPrice = json['ticket_price'];
    currency = json['currency'];
    host = json['host'];
    guests = json['guests'] != null ? json['guests'].cast<int>() : [];
    thumbnail = json['thumbnail'];
    description = json['description'];
  }

  Id localId = Isar.autoIncrement;
  int? id;
  String? name;
  String? topic;
  String? date;
  String? place;
  int? numberOfSeats;
  String? ticketPrice;
  String? currency;
  int? host;
  List<int>? guests;
  String? thumbnail;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['topic'] = topic;
    map['date'] = date;
    map['place'] = place;
    map['number_of_seats'] = numberOfSeats;
    map['ticket_price'] = ticketPrice;
    map['currency'] = currency;
    map['host'] = host;
    map['guests'] = guests;
    map['thumbnail'] = thumbnail;
    map['description'] = description;
    return map;
  }

}