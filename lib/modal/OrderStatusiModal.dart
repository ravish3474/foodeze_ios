
import 'dart:convert';

OrderStatusiModal orderStatusiModalFromJson(String str) => OrderStatusiModal.fromJson(json.decode(str));

String orderStatusiModalToJson(OrderStatusiModal data) => json.encode(data.toJson());

class OrderStatusiModal {
    OrderStatusiModal({
        this.status,
        this.data,
        this.rider,
    });

    String? status;
    Data? data;
    List<Rider>? rider;

    factory OrderStatusiModal.fromJson(Map<String, dynamic> json) => OrderStatusiModal(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        rider: List<Rider>.from(json["rider"].map((x) => Rider.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "rider": List<dynamic>.from(rider!.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        this.orderStatus,
    });

    String? orderStatus;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderStatus: json["order_status"],
    );

    Map<String, dynamic> toJson() => {
        "order_status": orderStatus,
    };
}

class Rider {
    Rider({
        this.id,
        this.riderUserId,
        this.assignerUserId,
        this.orderId,
        this.assignDateTime,
        this.acceptRejectStatus,
        this.acceptRejectDateTime,
        this.riderTransactionId,
        this.snap,
        this.created,
        this.userId,
        this.lat,
        this.long,
        this.country,
        this.state,
        this.city,
        this.addressToStartShift,
        this.previousLat,
        this.previousLong,
        this.rate_vk,
        this.rate_rider,
    });

    String? id;
    String? riderUserId;
    String? assignerUserId;
    String? orderId;
    DateTime? assignDateTime;
    String? acceptRejectStatus;
    DateTime? acceptRejectDateTime;
    String? riderTransactionId;
    String? snap;
    DateTime? created;
    String? userId;
    String? lat;
    String? long;
    String? country;
    String? state;
    String? city;
    String? addressToStartShift;
    String? previousLat;
    String? previousLong;
    String? rate_vk;
    String? rate_rider;

    factory Rider.fromJson(Map<String, dynamic> json) => Rider(
        id: json["id"],
        riderUserId: json["rider_user_id"],
        assignerUserId: json["assigner_user_id"],
        orderId: json["order_id"],
        assignDateTime: DateTime.parse(json["assign_date_time"]),
        acceptRejectStatus: json["accept_reject_status"],
        acceptRejectDateTime: DateTime.parse(json["accept_reject_dateTime"]),
        riderTransactionId: json["rider_transaction_id"],
        snap: json["snap"],
        created: DateTime.parse(json["created"]),
        userId: json["user_id"],
        lat: json["lat"],
        long: json["long"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        addressToStartShift: json["address_to_start_shift"],
        previousLat: json["previous_lat"],
        previousLong: json["previous_long"],
        rate_vk: json["rate_vk"],
        rate_rider: json["rate_rider"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rider_user_id": riderUserId,
        "assigner_user_id": assignerUserId,
        "order_id": orderId,
        "assign_date_time": assignDateTime?.toIso8601String(),
        "accept_reject_status": acceptRejectStatus,
        "accept_reject_dateTime": acceptRejectDateTime?.toIso8601String(),
        "rider_transaction_id": riderTransactionId,
        "snap": snap,
        "created": created?.toIso8601String(),
        "user_id": userId,
        "lat": lat,
        "long": long,
        "country": country,
        "state": state,
        "city": city,
        "address_to_start_shift": addressToStartShift,
        "previous_lat": previousLat,
        "previous_long": previousLong,
        "rate_vk": rate_vk,
        "rate_rider": rate_rider,
    };
}
