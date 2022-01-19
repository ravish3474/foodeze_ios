
import 'dart:convert';

CreateTicketModal createTicketModalFromMap(String str) => CreateTicketModal.fromMap(json.decode(str));

String createTicketModalToMap(CreateTicketModal data) => json.encode(data.toMap());

class CreateTicketModal {
    CreateTicketModal({
        this.status,
        this.data,
    });

    String? status;
    Data? data;

    factory CreateTicketModal.fromMap(Map<String, dynamic> json) => CreateTicketModal(
        status: json["status"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
    };
}

class Data {
    Data({
        this.msg,
        this.ticketId,
    });

    String? msg;
    String? ticketId;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        msg: json["msg"],
        ticketId: json["ticket_id"],
    );

    Map<String, dynamic> toMap() => {
        "msg": msg,
        "ticket_id": ticketId,
    };
}
