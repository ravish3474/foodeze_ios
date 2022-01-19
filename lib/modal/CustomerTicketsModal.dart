
import 'dart:convert';

CustomerTicketsModal customerTicketsModalFromMap(String str) => CustomerTicketsModal.fromMap(json.decode(str));

String customerTicketsModalToMap(CustomerTicketsModal data) => json.encode(data.toMap());

class CustomerTicketsModal {
    CustomerTicketsModal({
        this.status,
        this.data,
    });

    String? status;
    List<Datum>? data;

    factory CustomerTicketsModal.fromMap(Map<String, dynamic> json) => CustomerTicketsModal(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    Datum({
        this.ticketId,
        this.customerId,
        this.subject,
        this.resolved,
        this.tickTime,
    });

    String? ticketId;
    String? customerId;
    String? subject;
    String? resolved;
    String? tickTime;

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        ticketId: json["ticket_id"],
        customerId: json["customer_id"],
        subject: json["subject"],
        resolved: json["resolved"],
        tickTime: json["tick_time"],
    );

    Map<String, dynamic> toMap() => {
        "ticket_id": ticketId,
        "customer_id": customerId,
        "subject": subject,
        "resolved": resolved,
        "tick_time": tickTime,
    };
}
