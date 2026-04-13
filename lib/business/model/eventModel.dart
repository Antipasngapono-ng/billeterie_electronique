class Eventmodel {
  String? eventTitle;
  String? eventDate;
  String? eventPrice;
  String? eventLocation;
  String? eventDescription;
  int? eventTotalTickets;

  Eventmodel({
    this.eventTitle,
    this.eventDate,
    this.eventPrice,
    this.eventLocation,
    this.eventDescription,
    this.eventTotalTickets,
  });

  factory Eventmodel.fromJson(Map<String, dynamic> json) {
    return Eventmodel(
      eventTitle: json['eventTitle'] as String?,
      eventDate: json['eventDate'] as String?,
      eventPrice: json['eventPrice'] as String?,
      eventLocation: json['eventLocation'] as String?,
      eventDescription: json['eventDescription'] as String?,
      eventTotalTickets: json['eventTotalTickets'] is int
          ? json['eventTotalTickets'] as int
          : int.tryParse('${json['eventTotalTickets']}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventTitle': eventTitle,
      'eventDate': eventDate,
      'eventPrice': eventPrice,
      'eventLocation': eventLocation,
      'eventDescription': eventDescription,
      'eventTotalTickets': eventTotalTickets,
    };
  }
}