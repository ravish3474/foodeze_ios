
import 'dart:convert';

NotificationModal notificationModalFromMap(String str) => NotificationModal.fromMap(json.decode(str));

String notificationModalToMap(NotificationModal data) => json.encode(data.toMap());

class NotificationModal {
    NotificationModal({
        this.status,
        this.data,
    });

    String? status;
    List<Datum>? data;

    factory NotificationModal.fromMap(Map<String, dynamic> json) => NotificationModal(
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
        this.id,
        this.notification,
        this.type,
        this.created,
    });

    String? id;
    String? notification;
    String? type;
    String? created;

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        notification: json["notification"],
        type: json["type"],
        created: json["created"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "notification": notification,
        "type": type,
        "created": created,
    };
}
