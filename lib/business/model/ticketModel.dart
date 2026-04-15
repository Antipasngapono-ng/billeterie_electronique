class Ticketmodel {
  int? userId;
  int? eventId;
  String? ticketCode;
  String? qrCode;
  String? status;


  Ticketmodel({
  this.userId,
  this.eventId,
  this.ticketCode,
  this.qrCode,
  this.status,
});

  factory Ticketmodel.fromJson(Map<String, dynamic> json) {
    return Ticketmodel(
      userId: json['userId'] as int?,
      eventId: json['eventId'] as int?,
      ticketCode: json['ticketCode'] as String?,
      qrCode: json['qrCode'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'eventId': eventId,
      'ticketCode': ticketCode,
      'qrCode': qrCode,
      'status': status,
    };
  }
}
