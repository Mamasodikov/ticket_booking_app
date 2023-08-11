import 'dart:io';

class EventCreateModel {
  EventCreateModel({
    this.id,
    this.name,
    this.topic,
    this.date,
    this.place,
    this.numberOfSeats,
    this.ticketPrice,
    this.currency,
    this.thumbnail,
    this.description,
  });

  int? id;
  String? name;
  String? topic;
  String? date;
  String? place;
  int? numberOfSeats;
  String? ticketPrice;
  String? currency;

  File? thumbnail;
  String? description;
}
